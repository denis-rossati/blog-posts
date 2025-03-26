# Lessons from factorio to software development

This is my review regarding factorio.

For those who aren't familiar, factorio is an automation game. You are an engineer lost in an alien world, your goal is to get out of there. You have only natural resources at your disposal, so you need to process your way through.

You start small, smelting some iron, in a stone oven fueled by coal.

// GIF OF A BASIC SETUP

You end up in the 28th industrial revolution, with robot-servents and powering your base with nuclear power.

// GIF OF HUUUGE FACTORY

Now that you have youself all this technology, maybe it's time to build a rocket and get outta there, right? Wrong.

You die with your factory now. Your only desire is to make it work harder, better, faster and stronger.

---

It's funny because everybody says "oh you turn into a programmer when you play this game". I see this comes from, part of me agree, but the other, bigger, part of me thinks this is an  overstatement.

I have _some_ experience in the game, well spent 156 hours — to be honest, this is nothing compared to the rest of the player base. I'll make sure to multiply that a few dozen times — so I can speak with a minimal authority here: a lot of solutions and patterns there closely recall programming concepts, such as loading balancing, throughput, decoupling, etc, but that's not all. I'll have to think a lot with the logistics, data analyst and/or supply chain manager hat, you mostly don't have to think about memory, but you do need to think about input hygiene, data processing and output, ETL-ish stuff.

With that aside, I'm interested in the programming side of the picture here. This is "lessons from factorio to software development".

---

## Trade-offs

This might be the most consistent concept that you use daily as a software engineer. You need to understand what you can do, what you can't and how that will impact your factory.

It's interesting because this is VERY related to the unknown unknowns, which is a topic that I lightly covered in a [previous blog post](https://denis.my/blog/posts/what%20is%20up%20with%20overengineering%3F.md#:~:text=The%20unknown%20unknowns). You need to understand why are you taking a decision, and why you are not taking other decision, and remember: often, the "why not" is more important the "why". Taking a wrong turn might lead you to a ultra spaghetti factory beyond salvation, just like a codebase, but in a factory you don't have version control (well, you have your saves, but you know what I mean). This is the moment players generally nuke their base and start a fresh save, but know with more knowledge about why not do something, and a new-born unknown unknown turned into a known known.

The same applies to software projects. "why use a cache here instead of optimizing the query", "why create database replicas instead of scaling the main database vertically", "why not adding authorization to this internal service", you need to question yourself and understand the decision-making behind every design adopted in a system. Sometimes there's no reason for a piece of code to be there: might be a remaining of an old optimization, some rookie added without care, or it's just AI generated code.

Other lesson that you might learn from here is that saying "the difference between the novice and the master is the master has failed more times then the novice has tried"... something like that. When players fuck up their factories beyond any recognition, it's a good practice to just nuke it, start a new save with a new recognized mistake in the belt. Now you'll do things differently. The same goes for programming: don't be afraid of making mistakes, but be sure to learn from them.

Even time must be included in the trade-off, for example, why would I automate robot port production if I only need 1 through the whole game? I can just build one by hand and that's it. Of course there is a [relevant xkcd](https://xkcd.com/1205/) for this situation

## Attack surface

This game takes bug very seriously. As you increase your base, you'll start to produce pollution, which can irritate the planet native species. Bugs. 

You'll have to be aware that they can attack you from anywhere. You need to assess where your base can be attacked, and remediate that by building defenses or just exterminating the bug nest.

// GIF OF BASE SLASHING

This does not relate closely with software engineering other than you have a big complex app, you'll face issues with bugs, and sometimes hackers, even if the users aren't aware that they are hacking their way through your app. Those breachs in your app, for me, aren't different than a polluted, complex factory attracting all sorts of bugs and attacks to your system.

## Complexity

This is my favorite part of the game.

When starting a base, new players and veterans alike project their factories ad-hoc style, just like a POC. You need iron to create some red circuits, just drag a belt there and done. But as you get more complex recipes, this is unmaintainable:

// GIF OF COMPLEX CHAIN OF SUPPLY

You need a place where you are provided with the main materials, and then you could just pull the resources from that place. This is the main bus. A huge belt with iron, steel, copper, maybe processed materials like iron gears and circuits.

// GIF OF WELL FUNCTIONING MAIN BUS

This is good for a starter base that cannot afford the complexity of an ad-hoc factory. But even this design can become too much complex at scale. Imagine you need copper cables to build circuits, a very early game item, so you keep the copper cables only at the side of your main bus, without sending them to the main belts. But now you unlocked a big electric pole, red circuits, arithmetic combinators... all of them require copper cables to be built. Do you refactor your main bus to include the copper cable? Depending on how you implemented your base, this can become a problem. What if your copper production isn't able to feed all the side production chains? You have a scale problem.

## Microservices

"Hey! Microservices are a people scalability solution, not a throughput" — someone, probably.

Be calm. You are right, this is not a system solution, in fact, it only adds complexity, latency, eventual consistency and other problems, at the expense of team scalability, isolation and decoupling. Which are the problems that our factory might have at a fairly advance stage.

At some point, your main bus will get very messy, building some materials become far too complex and expensive to be handled in the same place as other complex materials, leaving you with no room to grow. Not to mention the coupling, if your main bus stops, or maybe one of the components that supply the main bus stops, your factory, or, if designed correctly, a small part of it stops, you shouldn't have a single point of failure at this point of the game.

Enter city blocks. This is a famous pattern, it isolates production by making a block responsible by one and only one product (with a few exceptions, which should be considered if you know what you are doing)

// CITY BLOCKS

The main benefit here is decoupling. The block doesn't know for who he is supplying the materials, the same applies for the other blocks. You don't even have the single point of failure anymore, since one block can be supplied by more than one block. That production unit only knows "I have this input, and I have to create this output".

There is some costs, though, this is when knowing the "why not?"s are useful:

- City blocks are expensive to build, you have to create train tracks, electric poles, the trains themselves, sometimes robot ports and so on for each block. Definitely not an early game pattern.
- They are expensive size-wise. Which if implemented incorrectly, you might get yourself attacked constantly by bugs, or being constrained by the game landscape, like cliffs.
- If you don't have enough production, you'll not have enough output, dealing with low throughput is a challenge in this pattern.
- Delay. This pattern depends on train movimentation, so if a block depends on a material input that is too far away, your output will be neglected.

## Vertical scaling, horizontal scaling, load balancing, the good stuff


## Too much planning

One of my most valuable lessons is that planning is good, but from a certain point, you are just trying to predict the future without consideration. As you gain experience, this future prediction becomes more accurate.

In factorio is not different, you know what caveats are coming, after a few tries and remakes of your base, you know when is worth redesigning the whole production chain or just adapting a small part of it and tolerate the technical debt.

When you have predictive workloads, it's much easier to know until where you should optimize it. As I said earlier, I don't mind creating a spaghetti when just starting my factory, I'll probably replace it with a main bus later. And I don't mind having low supply in my main bus at certain point, I know I can fix that with city blocks. Predictive workloads, man...

---
