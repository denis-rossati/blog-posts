# Book review: Concurrency in Go

From time to time I need to sharp knowledge that I haven't used in some time just like everyone. This time I choose Golang, which is a tool that I know very little, but can get around.

The first programming language I had contact with was Java, but I mostly learned to code with Javascript, then some good months of Python, and then PHP where I work. Between themselves, they are very different general-purpose languages, but they all share similar ways to set up common patterns.

Go feels different from the others, not only because of his unusual conventions, or slim code, or multiple value returns, but because I was being forced to think differently (IMO this a good thing). And it occurred much before I tried to use the more complicated stuff like channels or mutex, the error handling alone can be challenging when you are used to try/catch most of the exceptions because you actually need to consider what your user and/or other modules can see, and how should they see.

Knowing that tackling concurrency for first time is a difficult task, I choose to consult the old masters, and asked on r/golang which books they recommend regarding the matter. Katherine Cox-Buday's work was massively cited, and most of them agreed that it is the right path, those who disagreed said more or less that halfway it stops being a book for beginners. I decided to read it entirely, nonetheless.

## Who is it for?

Not for fresh beginners for sure, as it does not bother explaining basic syntax of the language, and it isn't for ultra experienced programmers, as it does not cover ultra-complex-blaster-advanced use cases. Rather, it is intended for the common folk, those who have some experience with Go, and maybe have trouble identified what patterns the language is trying to set up.

I have to add that knowing concurrency in other languages is not a must, because this was my case, and I could follow along very easily.

## What is it about?

The preface says a lot about the book:

```
Along the way the community was growing with the language, and we were collectively discovering best practices for working with concurrency in Go. (...) But there still weren’t many comprehensive guides on how to wield concurrency in Go in the community.

It was with this in mind that I set out to write this book.
```

This was the promise, and I'd be a testimony that the book can fulfill it. We know Go makes concurrency very easy, so writing about go concurrency wouldn't be different; The book is very easy to read and all code is explained by callouts in the examples, some patterns can be tricky, for example, the or-done pattern, which had me thinking for some good minutes before giving up to reading the callouts (thinking before going for the callouts is a good exercise, by the way), but that is mostly the nature of the pattern, not the author's fault.

The book has 6 chapters, and my edition had 238 pages, but I could read it in more or less 7 days.

### About each chapter


#### 1st chapter

It covers the basics mostly in a language agnostic manner, addressing why concurrency is important problem solver and common pitfalls, like deadlocks, starvations and race conditions.

#### 2nd chapter

It's the shortest, it's adds context about "Communicating Sequential Processes", the paper that influenced Go's concurrency model. It introduces some new concepts about Go's philosophy.

#### 3rd chapter

The first chapter where we talk more about the language itself and has more code in it. It covers the foundations of Go's concurrency, this one will teach and describe what tools are in your belt when it comes to handling concurrent routines, like channels, selects, `sync.WaitGroup`, `sync.Pool`, `sync.Cond`, stuff like that. 

It also has some nice insights about when you should use channels or tools from the sync package. I don't think this and exhaustive chapter about _every_ way to handle concurrency, but I'd say you can solve most trivial problems with them, much like Pareto's law. 

#### 4th and 5th chapters

Here we actually talk about the patterns themselves, which is what I was most eager to read about. You'll see a lot of examples dealing with concurrency problems, from basic cases to more complex ones. I don't think this chapter covers absolutely all you need to handle concurrency, but I can say for sure that you'll have good building blocks to architect bigger problems.

As I was reading the book, I was building some toy projects to put everything together. Happily, a task spawned at work where I had to create a job to read data from our database and according to the user's subscription, we should remove some data in other database. "Huh", I thought, "I read about pipelines these days in that book", so it was the opportunity to put the patterns in practice, I've created a pipeline that had like 2 stages — read and delete —, the read stage get some data in bulks, the other deleted data customer by customer because of a restriction we have, then I used a fan-out to create multiple copies of my stage. Since the second stage is the latest, then I didn't need to fan-in. I also had to use contexts and wait groups and some other neat stuff; all of them I learned in this book.

#### 6th chapter

Another short chapter, this one is about how Go handles concurrency at runtime level. You absolutely don't need to know this, but may be interesting to know how things work under the hood. By the way, Go (and other concurrent systems) use the work-stealing algorithm!! It was a nice surprise to see this algorithm in this book, because I've learned about it a few months ago, by the way, I invite you to read the post I about it right [here](https://denis.my/blog/posts/a9c49d91-2d44-1f7b-7c84-2b867cae097b).

## Was it worth the time?

For sure. And I'm keeping it as a cookbook whenever I need feel the need to use complex solutions, like the heartbeat pattern. As I said, it's not a book that everybody should read, since it's not for total beginners, and for experienced developers it may or may not cover unknown topics. Definitely a recommendation for developers that aren't 100% familiar with the Go's concurrency style.
