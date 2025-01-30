# What is up with overengineering?

Why is it so easy to get carried away when building software? I think it's easy to shoot in all directions when you have no clue which cases you should worry about, or when, like me, sometimes you don't notice the codebase growing and growing like a plague.

First off, I'll do no different from my sources and cite Wikipedia itself. They say that overengineering is...

```
(...) the act of designing a product or providing a solution to a problem that is complicated in a way that provides no value or could have been designed to be simpler.
```

...And...

```
German Second World War weapons, like the famous Tiger I tank or Panther tank, have been listed as examples of over-engineering, in comparison to their Soviet rivals such as the T-34.
```

I think I agree. While the Tiger line was one of the pinnacles of military engineering and a huge beast at the time — it is said that just the Maybach engine sound caused fear among Allied soldiers — its downfall was traveling on unstable ground like mud, sand or snow. And repairing it during battle was extremely hard.

Not to mention that its manufacture was a labor-intensive process[^1] due to its heavy armor and expensive parts. Any errors (which were not uncommon) cost not only a million dollars[^3] but also lives. Although it's said that it was mechanically reliable — when it wasn't in need of repair.

---

## Know your enemy

I'll try not to overengineer this post and go straight to the point. While doing the first draft, I thought about multiple reasons that can lead a codebase or a feature to become unnecessarily complex. But I'll try to stick with only two that I find interesting. I might write about other reasons later.

...

In the 50's, Joseph Stalin was afraid of a nuclear attack from the USA, and he demanded his engineers build a structure called Bunker GO-42 in Moscow. It is capable of holding around 600 people for 30 days without going outside and was supposed to be a command center for the Soviet Air Force's long-range nuclear bombers. What was once a military still stands today as a public museum — though this isn't much of an old building. The Derinkuyu Underground City was built in the 8th century and served as a refuge for Christians from persecution. It is estimated that up to 20 thousand people lived at once in that city. It also still stands, and visitors can explore the cave system!

I wonder why such structures are practically intact. Of course there are many factors, for example, the underground city was untouched until the 60s, and the bunker was never really bombed. But what makes me curious is how these structures are separated by a long time yet have the same purpose (protection) but very distinct characteristics (protection from what?). I see software building with similar eyes: we need to build, but build what? For whom? And why is it so easy to overkill things? One may argue that creating bunkers is far more expensive in costs and manpower. I say it depends — we are talking about a government nuclear bunker here, which took 14 years to complete. I think a domestic bunker could take about 4 years to build?! Certainly there is software that takes longer to build.

The point I'd like to stress here is: bunkers in general are not overengineered; they have one function, and they have to do it very well. I think software should behave the same way, otherwise, we might worry about unnecessary details that the user would pay attention.

I'm not a WWII specialist, only a curious person, and I'll try to back my claims with sources... Let's see what features the Tiger I had, but weren't much of a help . I'll try to be clear:

- The Feifel system was intended to be used in polluted and arid environments such as North Africa[^4];
- The wheels were great; they provided good stability and driving by using interleaved road wheels ([here's a good explanation for anyone wondering "what the heck is this?"](https://sturgeonshouse.ipbhost.com/topic/1134-what-the-hell-is-the-point-of-interleaved-road-wheels/));
- Initially implemented with the TZF 9b, the Tiger had incredible sight, granting VERY PRECISE aim for its time[^5];

Pretty cool, heh?

If you said "yes", I agree with you. Indeed it had cool features, but were they actually used?

The filtration system was often removed by the crew, because it added extra complexity and weight that they didn't need. When Tigers were deployed, most battles happened in Europe, where dust wasn't a problem. The component removal was so common that in later models the filter was detachable.

The wheels weren't ready for mud and snow, leading them to become immobilized. This alone was one of the greatest reasons why Tigers fell in battle — you might have heard about what happened in Leningrad or Kursk. Not to mention that this wheel design was a huge danger because having to repair them required engineers to remove a lot of outer layers first... Just imagine being this exposed while in the middle of violent shooting.

The Tiger was designed for long-range engagements, and his gunsight was impressive. BUUUT most battles were at close quarters... Just a few good hits to the binocular vision and now you have a whole tank crew fighting difficulties to aim.

What I'm trying to emphasize here is that if you are building amazing stuff with no utility, you have a bunch of... inutilities! Your users won't need the extra complexity (like the dust filters) or use your product in unintended ways (like driving the tank on snow).

Know your enemy, learn what your user needs, or at least understand what your business requirements are and try to stick to that. Think about preventing the user from producing edge cases rather than creating logic branches to handle your stubborn user.

If you really feel like adding useless features, why not spend your energy making the software more flexible and receptive to changes? Wait for the user to tell you what they are missing in your software, analyze if this is a valid concern, then add it.

---

I'll try to stop with the WWII references.

I think overengineering is, all the more, a time problem: wasting time thinking, designing, and implementing a feature in an overburdened system has everything to do with stressful and boring work. The edge cases for a system with so many unnecessary features can get out of control quickly. It just takes away all the joy of working in a flexible and receptive environment and turns into a waste of energy (yours, and the electrical energy running the computer). By consequence, overengineering is a money problem: you have a stakeholder to please, and if you are taking away their profit by wasting time on useless tasks that would otherwise be non-existent in a lean system, you might get fired, because your final user/stakeholder doesn't care about your silly technical debts, and then your profit is at risk. I'm not too interested in money, but a good work environment is reason enough for me to try to use some good practices.

---

## The unknown unknowns

This is a concept that I learned in my first year of software development. It was a huge help because it helped me not try to embrace the world (which I often do, unconsciously), but enjoy the process. We can define a little matrix right here:

|                  | Aware                                                                                               | Not aware                                                                                                                                                                                                             |
|------------------|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Understand       | We understand it, and we know it. These are "known knowns". Sweet!                                  | We understand it, we just didn't know that this was a thing. An unknown known. That's fair.                                                                                                                           |
| Don't understand | Known Unknowns. We know that we don't know, and that's fine, we'll get there someday, if necessary. | Unknown unknowns. This is hell for me. WHAT DO YOU MEAN THERE ARE THINGS THAT I DON'T KNOW EXIST???!!! I can't stand the unknown! I might at least turn this thing into a known unknown to sleep peacefully at night. |

These concepts themselves were a "known unknown" for me. I knew them, I just didn't have a name for them or know that this was already a known thing.

You might have guessed it, but overengineering has a lot to do with unknown unknowns. Imagine you know EXACTLY which cases you'll have to handle with your program (for example, a list of inputs from [advent of code](https://adventofcode.com)). If you know your needs from A to Z, then you obviously need no more than that. Unless you want more edge cases, complexity and bugs to deal with. Again, know your enemy and learn what problem you are solving, and for whom you are solving it — that's strategy. Do this and you'll be fine because you've just turned a lot of unknown unknowns into known knowns, or maybe into other good variants like known unknowns or unknown knowns. Now you know.

Experienced engineers have a little something in this respect. They've gone through a lot of production issues and complicated problems; they know (or should know) how to break problems into small pieces and research how to solve those pieces. Or at least have some instinct when something might turn into a problem, or when they need to see it to believe it.

I'm not extremely experienced, but I've observed both beginners and experienced developers doing critical thinking, and I can safely say that the difference between the two is much more than talent or how many hours you've spent sitting down. I think the main difference is that one has fewer unknown unknowns — they still have a lot of unknown unknowns, they're humans, after all. They just have fewer unknown unknowns. I'll tell you more: you can only shrink your unknown unknowns by exposing yourself to moments of critical thinking. Build something new, something complicated, even if that thing doesn't come in handy immediately. Engineering is a creative profession, so you need to be comfortable getting things out of your mind.

---

There's a quick story to wrap up this post that I want to share. At work, I was once told (shout out to Fryuni, check out his [work](https://github.com/fryuni) and [blog](https://fryuni.dev/)) about what kind of data structure IDEs generally use under the hood for text editing. The name itself was a matter of interest to me: ropes[^4]. I'm not going into the algorithm details in this post. My point is: just before he told me, this subject was an unknown unknown; after he told me what the heck that was, it became a known unknown. It was then just a matter of will to turn it into a known known.

I went on an adventure implementing my own rope data structure. I struggled a little, but it was a good pain, just like a workout — you know it's good for your health, you need to build that resilience when facing new problems.

Was my solution inefficient? Hell yes.

Did I overengineer? HELL YES.

Did it work? Barely.

Did I ever have to use a rope? Well... No.

After I quit the suffering of having to think, I compared my solution with [a battle-tested one](https://github.com/zyedidia/rope/blob/master/rope.go). God, it was so much different. I could see clearly what I got wrong, where I didn't achieve that simple-complex balance.

Anyway, even though I never used ropes, the knowledge I gained was useful enough when later I had a little energy boost and got into creating my own SQL database with the company of [The Art of SQL](https://www.amazon.com.br/Art-SQL-Stephane-Faroult/dp/0596008945). When I started thinking about how a database might work under the hood, I knew that somewhere I would probably need a self-balancing search tree (and real databases do use these kinds of data structures), because I needed efficient and sequential lookups, insertions and deletions, just like when editing a text.

I failed miserably to create an ACID-compliant database, but again, I gathered a lot of unknown unknowns and turned them into at least known unknowns. That opened my eyes to a lot of optimizations that I could apply during work or hobby projects, as well as predict problems.

Don't be afraid and know your enemy! Don't let unknown unknowns be a problem!

---

If you want to go deeper, I used these sources for inspiration. I'd give them a chance.

- https://hbr.org/2006/02/defeating-feature-fatigue

- https://ntrs.nasa.gov/api/citations/19930009672/downloads/19930009672.pdf

- https://openlibrary.org/books/OL14918996M/Britain_and_atomic_energy_1939-1945

---

#### Observations

This was my first blog post ever about software engineering, I'm much more used to conversation and commenting in other person's posts. I covered few topics because I rewrote this, no kidding, more than 20 times, and each version was a little shorter than the previous one. I'm still not very proud of the final result, but always remember that this is a living document; I'll always try to improve it a little.

If you're seeing this at the time I'm writing these words (2025-01-30), maybe you're seeing a very raw blog:

![blog in its first days](https://storage.googleapis.com/blog-the-wall/public/2025-01-30_16-19.png)

This is because I purposely made this website veeery underengineered (if this word exists) because I want to leave this door open to talk more about this subject and include my experience in creating this blog.

There's a lot to come that I want to share and write about. Not only, but mostly about software building.

I think I might write about ropes or other data structures that you might use every day and don't know about; it's an interesting topic.

Feel free to leave any comments in the repository where I store all these posts (see the link at the top of the page). Every suggestion is much appreciated.

---

[^1]: [https://tankmuseum.org/article/building-a-tiger-tank](https://tankmuseum.org/article/building-a-tiger-tank/#:~:text=They%20worked%20in%20two%2012%20hour%20shifts%2C%20with%20the%20night%20shift%20up%20to%2050%25%20less%20productive%20than%20the%20day%20shift)

[^2]: [https://tanks-encyclopedia.com/ww2/germany/panzer-vi_tiger.php](https://tanks-encyclopedia.com/ww2/germany/panzer-vi_tiger.php#:~:text=Each%20Tiger%20was%20calculated%20to%20cost%20RM250%2C800%20(Reichsmarks)%20to%20build%20compared%20to%20just%20RM117%2C100%20for%20a%20Panther%20and%20RM103%2C462%20for%20a%20Panzer%20IV.)

[^3]: [https://en.wikipedia.org/wiki/Doln%C3%AD_V%C4%9Bstonice](https://en.wikipedia.org/wiki/Doln%C3%AD_V%C4%9Bstonice#:~:text=a%20small%20settlement%20of%20mammoth%20hunters%20consisting%20of%20huts%20built%20with%20rocks%20and%20mammoth%20bones%20was%20founded%20on%20the%20site%20of%20what%20is%20now%20Doln%C3%AD%20V%C4%9Bstonice)

[^4]: [https://tiger1.info/EN/Feifel-air-precleaners.html](https://tiger1.info/EN/Feifel-air-precleaners.html)

[^5]: [https://tigertank181.com/08_tzf9b_gunsights.htm](https://tigertank181.com/08_tzf9b_gunsights.html)


