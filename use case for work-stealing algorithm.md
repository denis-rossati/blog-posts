# Quick use case for work-stealing algorithm

I read about an interesting algorithm a month ago when we faced a little problem involving multiple queues reading from the same source, and trying to send unavailable data. I'll get there, first I'll explain what happened.

## Some context

For those who don't know, I work at [Croct](https://croct.com/), which is a headless CMS with some neat features like A/B testing, personalization, analytics and more.

[We have an open-source SDK](https://github.com/croct-tech/sdk-js). This SDK needs to send data to our backend so we can track what is happening in our clients' applications. We call these data "beacons".

The SDK uses a queue to perform some optimizations and to manage those beacons. Under the hood, [the queue is just a session storage property](https://github.com/croct-tech/sdk-js/blob/2da50e3fcb810d77bcd2a867c9bb7b0269d1dc41/src/container.ts#L303-L311). You can see how we operate the queue interface [here](https://github.com/croct-tech/sdk-js/blob/2da50e3fcb810d77bcd2a867c9bb7b0269d1dc41/src/channel/queuedChannel.ts).

### A pesky "bug"

Sharp readers might already have reckoned, but one tab = one SDK instance, and as you can see [here](https://github.com/croct-tech/sdk-js/blob/2da50e3fcb810d77bcd2a867c9bb7b0269d1dc41/src/container.ts#L336-L339), we use the same session storage field for every SDK instance. So far, this is not a big deal: multiple tabs feed the same session storage queue, which is eventually consumed.

The problem is that one SDK instance does not know that others might exist. So, if two SDK attempt to consume the queue at the same time, one of them will fail [here](https://github.com/croct-tech/sdk-js/blob/2da50e3fcb810d77bcd2a867c9bb7b0269d1dc41/src/queue/persistentQueue.ts#L47-L49) since the event will already be dequeued.

This is not a big deal either because no beacons were being lost, it's just the one of the SDKs complaining that it tried to read an empty queue while others already sent all beacons. The worst that will happen is the client receiving an error in the browser console, and this might bother some people, so we considered trying to fix it as long as it does not require big changes.

### Alternatives

#### Storage event

I'm not a front-end dev, so I have some gaps when it comes to how browsers work. First thing I thought was "huh, isn't there a 'storage' event? Why haven't we used that from the start?", but 30 seconds later I came to the realization that this would fix absolutely nothing. Let's say that one SDK enqueues a beacon, and everybody tries to dequeue that beacon, and one SDKs gets the beacon, and everybody else is now reading an empty queue, and now we got the error again.

#### Tab leader and almost overengineering

Next idea I had was to have a tab leader, which is fairly simple: all SDKs push beacons to the queue, but only one is responsible for sending them. Easy.

First of all, we need to have a mechanism to determine which tab is the leader. I thought about using a session storage field like `tab-leader: [tab-id]`. Now everybody sends beacons, everybody _tries_ to send the beacon, but before doing that, it must check if the tab is the leader. If not, do nothing. If yes, send the beacon. Easy.

What should happen if the leader tab is closed?

One of my first ideas to elect a leader was to rely on [broadcast channel](https://developer.mozilla.org/en-US/docs/Web/API/BroadcastChannel), everybody sends their tab IDs, everybody receives the tab IDs and stores it internally, since the broadcast channel is assured to be sync, it is a "last write wins" election. But how the last tab knows that it won? Maybe we should send acknowledgement signals to each other, and the last tab will know that it was chosen to be leader. And what if the chosen tab freezes? Maybe it should send an ack-ack, just like TCP does. Well... at this point I thought it was too much complexity for a harmless bug, so I came up with another election method.

Maybe everybody should try to become the leader by writing its own tab id to a `tab-leader` property in the session storage. Then, the next time everybody _tries_ shift a beacon from the session storage, they need to check whether they are chosen tab.

This is fine. But how to avoid every SDK from trying to become the leader while the leader is alive? A sort of heartbeat/health check/ping-pong/whatever name you like, is required: every X seconds, the leader writes the current timestamp to a session storage field, every SDK keeps reading that field and if the timestamp is too old, a new election is started, that is, the SDK writes its tab ID in the `tab-leader` field. This also helps when tab leader freezes, since other tabs will also pick-up beacons produced by the freezed tab.

This could be the needed fix. We won't have "split-brain condition", common in distributed coordination systems, because before trying to send a beacon, it always checks for the tab leader.

But again, this is kind of too much work... elections, leaders, heartbeats... What if everything wasn't so bright-sided? We need thieves!


---

## Work-stealing

Shortly after I shot my ideas, I was presented with the [work-stealing algorithm](https://en.wikipedia.org/wiki/Work_stealing). It is famous for handling multithreaded programs, but it fits perfectly in what we need.

In the real world, a worker thread has its own tasks, it dequeues it and executes it. Usually, those must be executed sequentially, however, tasks might generate sub-tasks that could be done in parallel, these tasks are pushed at the bottom of the worker queue. When one worker has no work to be done, it becomes a filthy thief, stealing those tasks that can be done sequentially, balancing the load across workers;

In my use case, it's even easier since our backend can handle beacons out of order, so every queue can be stolen without criteria.

It's very simple, but I'll illustrate for those who are more visual.

Each tab have its own queue and beacons.

![Each tab has its own queue](https://storage.googleapis.com/blog-the-wall/public/work-stealing/full-queues.png)

If a tab empties its queue, it randomly chooses other queue and take beacons from there.


![Stealing other queues](https://storage.googleapis.com/blog-the-wall/public/work-stealing/empty-queue.png)

The amount of stolen beacons may vary, but in this example I stole half of the other queue.

When a tab has a non-empty queue, it stops the criminality.

It's worth noticing that if more beacons are produced, duplicated or even out of order, we don't need to worry as our backend knows how to handle those just fine B)

---

Just like that, we don't need to deal with heartbeats or elections, or even leaders! This is totally anarchic. We don't have to worry about avoiding split-brain conditions or even tabs freezing or closing.

There is a very small drawbacks in my proposal, though. _randomly_ choosing a queue is not ideal, since it could lead to some queues having more work stolen than others, leading to a bad balancing.

That's it. Thanks.


