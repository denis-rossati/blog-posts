# Lessons from factorio to software development

This is my review regarding factorio.

For those who aren't familiar, factorio is an automation game. You are an engineer lost in an alien world, your goal is to get out of there. You have only natural resources at your disposal, so you need to process, refine and assemble your way through.

You start small with coal-fueled machinery, smelting some iron in a stone oven. Primitive stuff.

![Small iron plate setup](https://storage.googleapis.com/blog-the-wall/public/small-base-setup.png)

Soon enough you'll end up in the 28th industrial revolution.

![Complex setup](https://storage.googleapis.com/blog-the-wall/public/ant-nest-base.jpeg)

<sub>_This base doesn't even make sense, I just wanted to show that it can become real complex real quick._</sub>

Now that you have yourself all available technology, maybe it's time to build a rocket and get outta there, right? Wrong.

You die with your factory now. Your only desire is to make it work harder, better, faster and stronger.

---

If you spent 5 minutes at the community, I'll see some people say things more or less like "oh you turn into a programmer when you play this game". I see this comes from and I mostly agree, after all, it's an automation game, but I think we can expand this a thought bit more.

I have _some_ experience in the game, well spent 156 hours at the time I'm writing this post — to be honest, this is nothing compared to the real veterans — so I can speak with a minimal authority here: a lot of solutions and patterns in the game closely recall programming concepts, such as loading balancing, throughput, decoupling, etc., but that's not all. It has a lot to do with the logistics, data analysis and supply chain management.

With that aside, I'm interested in the programming side of the picture here. This is "lessons from factorio to software development".

---

## Trade-offs

This might be the most consistent concept that you use daily as a software engineer. You need to understand what you can do, what you can't, which problems you can tolerate and how that will impact your factory.

It's interesting because this is VERY related to the unknown unknowns, which is a topic that I lightly covered in a [previous post](https://denis.my/blog/posts/what%20is%20up%20with%20overengineering%3F.md#:~:text=The%20unknown%20unknowns). You need to understand why are you taking a decision, and why you are not taking other decision, and remember: often, the  "why" is more important than the "how", and "why not" is more important the "why". Taking a wrong turn might lead you to an ultra spaghetti factory beyond salvation, just like a codebase, but in a factory you don't have version control (well, you have your saves, but you know what I mean). When the spaghetti takes over, this is the moment players generally nuke their base and start a fresh save, but know with more knowledge about why not do something, and a new-born unknown unknown turned into a known known.

The same applies to software projects. "why use a cache here instead of optimizing the query", "why create database replicas instead of scaling the main database vertically", "why not adding authorization to this internal service", you need to question yourself and understand the decision-making behind every design adopted in a system. Sometimes there's no reason for a piece of code to be there: might be a remaining of an old optimization, some rookie added without care, or it's just AI generated code.

Other lesson that you might learn from here is that saying "the difference between the novice and the master is the master has failed more times then the novice has tried"... something like that. After you nuke your old factory, start a new save with a new recognized mistake in the belt. Now you'll do things differently. The same goes for programming: don't be afraid of making mistakes, but be sure to learn from them.

Even the time it takes to automate stuff should be included in the trade-off, for example, why would I automate robot port production if I only need 1 through the whole game? I can just build one by hand and that's it. Here's a [relevant xkcd](https://xkcd.com/1205/) for this situation

## Attack surface

This game takes bugs to other level. As you increase your base, you'll start to produce pollution, which can irritate the planet native species, which happens to be arthropoda-like creatures. 

You'll have to be aware that they can attack you from anywhere. You need to assess where your base can be attacked, and remediate that by building defenses or just exterminating the bug nest.

![Slaying bugs!](https://storage.googleapis.com/blog-the-wall/public/bug-slaying.gif)

This reminds me of a complex project trying to achieve everything at the same time. A huge mess. Excessive complexity hides many threats that can easily pass unnoticed. Such is a huge factory that a lot of exposed machinery. Often, your application won't be attacked by hackers, but by your very users, even though they aren't aware that they are exploiting the application.

I don't have a lot to say here, if you don't know what I am talking about, try creating a huge application without care, than come back here. Now that we're talking about complexity, let's get to the next topic.

## Complexity

This is my favorite part of the game.

When starting a base, new players and veterans alike project their factories ad-hoc style, just like a POC. You need iron to create some red circuits, just drag a belt there and done. But as you get more complex recipes, the base become more and more unmaintainable:

![Confusing and messy factory](https://storage.googleapis.com/blog-the-wall/public/spaghetti-base-factorio.png)

<sub>I had to take this picture from the internet, because I don't create spaghetti factories. Ever!!</sub>

You need a place where you are provided with the main materials, and then you could just pull the resources from that place. This is the main bus. A huge belt with iron, steel, copper, maybe processed materials like iron gears and circuits.

The relation here is pretty obvious, you can't choose an architecture and stick with it forever, you need to adapt your solutions to your scalability needs, sometimes even redo them from the ground. For example, a single database instance will not fit a global scale application, you'll need to adapt your infrastructure to have replicas, or sharding, common industry practices.

![Main bus producing advanced circuits and creating a copper cable lane](https://storage.googleapis.com/blog-the-wall/public/factorio-main-bus.png)

After a spaghetti factory, players move to a bus pattern. This is good for bases that no longer can afford the complexity of an ad-hoc factory. But even this design can become too much complex at scale. Imagine you need copper cables to build circuits, a very early game item, so you keep the copper cables only at the side of your main bus, without sending them to the main belts. But now you unlocked a big electric pole, red circuits, arithmetic combinators... all of them require copper cables to be built. Do you refactor your main bus to include the copper cable? Depending on how you implemented your base, this can become a problem. What if your copper production isn't able to feed all the side production chains? You have a scale problem again.

## Microservices

"Hey! Microservices are a people scalability solution, not a throughput" — someone, probably.

Calm down. You are right, this is not a system solution, in fact, it only adds complexity, latency, eventual consistency and other problems at the expense of team scalability, isolation and decoupling. Which are the problems that our factory might have at a fairly advanced stage.

At some point, your main bus will get very messy, building some materials become far too complex and expensive to be handled in the same place as other complex materials, leaving you with no room to grow. Not to mention the coupling, if your main bus stops, or maybe one of the components that supply the main bus stops, your factory, or, if designed correctly, a small part of it stops, you shouldn't have a single point of failure at this point of the game.

Enter city blocks. This is a famous pattern, it isolates production by making a block responsible by one and only one product (with a few exceptions, which should be considered if you know what you are doing)

![Single city block](https://storage.googleapis.com/blog-the-wall/public/single-city-block.png)

Notice how is exactly what single responsibility principle. You can compose a whole factory with these blocks. Here is one set of blocks that I actually built in my current save:

![City blocks](https://storage.googleapis.com/blog-the-wall/public/city-blocks.png)

<sub>You can even picture how I'm slowly transitioning from main bus to city blocks.</sub>

The main benefit here is decoupling. The block doesn't know for who he is supplying the materials, the same applies for the other blocks. You don't even have the single point of failure anymore, since one block can be supplied by more than one block. That production unit only knows "I have this input, and I have to create this output".

There is some costs, though, this is when knowing the "why not?"s are useful:

- City blocks are expensive to build, you have to create train tracks, electric poles, the trains themselves, sometimes robot ports and so on for each block. Definitely not an early game pattern.
- They are expensive size-wise (compare the size of the block to the main bus in the image above). If implemented incorrectly, you might get yourself attacked constantly by bugs, or being constrained by the game landscape, like cliffs.
- If you don't have enough production, you'll not have enough output, dealing with low throughput is a challenge in this pattern.
- Delay. This pattern depends on train movimentation, so if a block depends on a material input that is too far away, your output will be neglected.

## Too much planning

One of my most valuable lessons is that planning is good, but if planning too far ahead might be as good as trying to predict the future without consideration. As you gain experience, this future prediction becomes more accurate.

Similarly, in factorio you know what caveats are coming, and after a few tries and remakes of your base, you know when is worth redesigning the whole production chain or just adapting a small part of it and tolerate the technical debt.

When you have predictive workloads, it's much easier to know what and where an optimization is fit. As I said earlier, I don't mind creating a spaghetti when just starting my factory, I'll probably replace it with a main bus later. And I don't mind having low supply in my main bus at certain point, I know I can fix that with city blocks. Predictive workloads, man...
