# What is up with overengineering?

Why is it so easy to get carried away when building software? Sometimes when I'm writing, I enter on a trance that I can
only get out when I notice something weird going on in my code, mostly I can get out of it when I ask myself "is this an
overkill?".

In 50s Joseph Stalin was afraid of a nuclear attack from the USA built a structure called Bunker GO-42 in Moscow.
Capable of holding around 600 people for 30 days without going outside, it was supposed to be a command center for the
Soviet Air Force's long-range nuclear bombers, and what was once a military complex, today it still stands as a public
museum. But this isn't much of an old building, the Derinkuyu Underground City was built in the 8th century and served
as a refuge for Christians from persecution, it is estimated that up to 20 thousand people lived at once in that city,
it still stands and visitors can explore the cave system!

I wonder why such structures are practically intact. Of course there are many factors, for example, the underground city
was untouched until the 60s, and the bunker wasn't really bombed. But what makes me curious is how these structure are
separated by time, and yet have the same purpose (protection), but very distinct characteristics (protect from what?). I
see software building with similar eyes, we need to build, but build what? For who? And why is it so easy to overdo
things? One may argue that creating bunkers are far more expensive in costs and manpower to be built, I say it may
depend, we are talking about a government nuclear bunker here, which took 14 years to be done, I think a domestic bunker
could take like 4 years be built?! Certainly there are software that take longer to be built.

The point I want to stress is: software is often built differently, by different people. But bunkers (and other
constructions I reckon) are very similar overall. I think this has a lot to do with how we prioritize our features.

---

First off, I'll do no different from my sources and cite wikipedia itself. Here's what overengineering is defined there:

```
Overengineering, or over-engineering is the act of designing a product or providing a solution to a problem that is complicated in a way that provides no value or could have been designed to be simpler.
```

Funny enough, wikipedia also cite WWII references:

```
German Second World War weapons, like the famous Tiger I tank or Panther tank, have been listed as examples of over-engineering, in comparison to their Soviet rivals such as the T-34.
```

I think I agree, while the Tiger line was one of the pinnacles of military engineering and a huge beast at the time — it
is said that just the engine sound caused panic among the nazi enemies — its downfall was travelling in unstable ground
like mud, sand or snow. And repairing it while in the battle was extremely hard.

Not to mention that it was a manufactured labor-intensive process[^2] due to its heavy armor and expensive parts. Any
errors (which were not uncommon) costed not only a million dollars[^3], but also lives. Although it's said that it was
mechanically okay to maintain.

---

ENOUGH WITH WWII

I want to start by saying that overengineering is, all the more, a time problem: wasting time thinking, designing and
implementing a feature in an overburdened system has everything to do with a stressful and boring work, the edge cases
for a system with so many unnecessary features spreads rapidly like a plague, it just takes away all the joy of working
in a flexible and receptive environment and turns into a waste of energy (yours, and the electric energy running the
computer). By consequence, overengineering is a money problem: you have a stakeholder to please, and if you are taking
the profit from him by wasting time in useless tasks that would be otherwise non-existing in a lean system, you might
get fired, because your final user/stakeholder doesn't care about your silly technical debts, and then your profit it's
at risk.

---

## The unknown unknowns

This is a concept that I learned in my first year of software development, they were a huge because it helped me a
little to not try to embrace the world, but enjoy the process. We can define a little matrix right here:

|                  | Aware                                                                                               | Not aware                                                                                                                                                                                                             |
|------------------|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Understand       | We understand it, and we know it. This is "known knowns". Sweet!                                    | We understand it, we just didn't knew that this was a thing. A unknown known. That's fair.                                                                                                                            |
| Don't understand | Known Unknowns. We know that we don't know, and that's fine, we'll get there someday, if necessary. | Unknown unknows. This is hell for me WHAT DO YOU MEAN THERE IS THINGS THAT I DON'T KNOW THAT EXIST???!!! I can't stand the unknown, I might at least turn this thing into known unknown to sleep peacefully at night. |

Those concepts themselves were a "known unknown" for me. I knew them, I just didn't have a name for them or knew that
this was already a known thing.

You might have guessed it, but overengineering has a lot to do with unknown unknowns. Imagine you know EXACTLY which cases you'll have to handle with your program (for example, a list of inputs from [advent of code](https://adventofcode.com)), if you know from A to B your necessities, then you obviously need no more than that. Unless you want more edge cases and bugs to deal with. Know your enemy, learn what problem you are solving, and for who you are solving, that's strategy, do these you'll be fine because you just turned a lot of unknown unknowns into known knowns, or maybe into other good variants like know unknowns or unknown knowns, now you know.

Experienced engineers have a little something in respect to this. They've gone through a lot of production issues and complicated problems, they know (or should know) how to break problems into small pieces and research how to solve those said pieces. Or at least have some instinct when something might turn into a problem, or when they need to see to believe it.

I'm not extremely experienced, but I observed both beginners and experienced developers doing critical thinking, and I can safely assume that the difference between the two is much more than talent or how many hours you spent sat down. I think the main difference is that one has less unknown unknowns (notice that I used "less", not "few"), and I can say more: you can only shrink your unknown unknowns by exposing yourself to moments of critical thinking. Build something new, something complicated, even if that thing doesn't come in hand immediately, engineering is a creative profession, so you need to be comfortable in getting things out of your mind.

There's a little story I want to share. At work, I was once told (shout out to Fryuni, check out his [work](https://github.com/fryuni) and [blog](https://fryuni.dev/)) what kind of data structure IDEs generally use under the hood for text editing, the name itself was a matter of interest to me: ropes[^4]. I'm not going into the algorithm details in this post, my point is: just before he told me, this subject was an unknown unknown, after he told me what the heck that was, it became a known unknown, it was a matter of will to turn it into a known known.

I went on an adventure implementing my own rope data structure. I struggled a little, but it was a good pain, just like a workout, you know it's good for your health, you need to build that resilience when facing new problems. 

Was my solution inneficient? Hell yes. 

Did I overengineered? HELL YES. 

Did it work? Barely.

Did I ever had to use a rope? Hell nah.

After I quited the suffering of having to think, I compared my solution with [a battle tested one](https://github.com/zyedidia/rope/blob/master/rope.go). God, it was so much different, I could see clearly what I got wrong, where I did not got that simple-complex balance.

I think I might write about ropes or other data structures that you might use everyday and don't know.

Anyway, even though I never used ropes, the knowledge I gained was useful enough when later I had a little energy boost and got into creating my own SQL database with the company of [the art of SQL](https://www.amazon.com.br/Art-SQL-Stephane-Faroult/dp/0596008945). When I started thinking about how a database might have worked under the hood, I knew that somewhere I would probably need a self-balancing search tree, because I need efficient and sequential lookups, insertions and deletions, just like when editing a text.

I failed miserably to create a ACID compliant database, but again, I gathered a lot of unknown unknowns and turned them into at least know unkonws, that opened my eyes to a lot of problems that could happen during work or in hobby projects.

Don't be afraid and known your enemy! Don't let unknown unknowns be a problem!

---





---

[^1]: [Göbekli Tepe is a sanctuary dated around 9600–7000 BCE, when the last Ice Age was ending!](https://en.wikipedia.org/wiki/Doln%C3%AD_V%C4%9Bstonice#:~:text=a%20small%20settlement%20of%20mammoth%20hunters%20consisting%20of%20huts%20built%20with%20rocks%20and%20mammoth%20bones%20was%20founded%20on%20the%20site%20of%20what%20is%20now%20Doln%C3%AD%20V%C4%9Bstonice)

[^2]: [One Tiger I is said to take 14 days with 12-hour shifts (but take in consideration that those 8.000 workers didn't work only in those Tigers)](https://tankmuseum.org/article/building-a-tiger-tank/#:~:text=They%20worked%20in%20two%2012%20hour%20shifts%2C%20with%20the%20night%20shift%20up%20to%2050%25%20less%20productive%20than%20the%20day%20shift)

[^3]: [A Tiger costed around 250k Reichsmark at that time, but it's talked everywhere that one Reichsmark could be converted to about 2.50 USD](https://tanks-encyclopedia.com/ww2/germany/panzer-vi_tiger.php#:~:text=Each%20Tiger%20was%20calculated%20to%20cost%20RM250%2C800%20(Reichsmarks)%20to%20build%20compared%20to%20just%20RM117%2C100%20for%20a%20Panther%20and%20RM103%2C462%20for%20a%20Panzer%20IV.)

[^4]: [A Tiger costed around 250k Reichsmark at that time, but it's talked everywhere that one Reichsmark could be converted to about 2.50 USD](https://tanks-encyclopedia.com/ww2/germany/panzer-vi_tiger.php#:~:text=Each%20Tiger%20was%20calculated%20to%20cost%20RM250%2C800%20(Reichsmarks)%20to%20build%20compared%20to%20just%20RM117%2C100%20for%20a%20Panther%20and%20RM103%2C462%20for%20a%20Panzer%20IV.)

References:

https://hbr.org/2006/02/defeating-feature-fatigue
https://ntrs.nasa.gov/api/citations/19930009672/downloads/19930009672.pdf
https://openlibrary.org/books/OL14918996M/Britain_and_atomic_energy_1939-1945
https://www.infoworld.com/article/3589545/is-your-software-architecture-as-clean-as-your-code.html
https://www.reddit.com/r/webdev/comments/1cuumbw/opinion_about_overengineering/
