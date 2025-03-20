# Vibe coders, you are already outdated

"_What if we added a dumbass that is constantly wrong to every product?_" — tech bro, probably.

Today I was mocking around with friends at work. It's some good 30 mins that we discuss something totally random, some weeks ago was "why 4 in roman numbers is IV and not IIII? And why 4 in japanese is a weird square and not four dashes?". Those are interesting questions, look it up

Today's subject was vibe coding, and we came to the conclusion that this is a thing since the beginning of software engineering. Vibe coding is just extreme go horse. **BUT. ON. STEROIDS.**

Before you proceed, this **is** a rant, this **is** me taking something off my chest, this **IS** a text with unnecessary uppercase and bold words. I'd rather believe that vibe coding is just a big joke that is getting over my head.

Also, this post is inspired by "[doing dumb stuff faster is still dumb](https://anniemueller.com/posts/doing-dumb-stuff-faster-is-still-dumb)" by Annie Mueller, I'd check that if you want to read a pocket version of this post.

---

We need to recognize something, too. Vibe coding as describe in [this podcasty... eh... thing](https://www.youtube.com/watch?v=IACHfKmZMr8) is a technique to ship products as quickly as possible. I can see that clearly. But startups are well known for their spaghetti code due to the fast pace at initial stages, which is understandable. Add that to massive trash-generated code. What are we trying to accomplish here?

Be real, you'll not stop "vibe coding" after releasing the MVP, this is now rooted in your culture deck. At the video, those guys said that this is the situation where you'll gonna need real engineers. Be prepared to spend a salty sum to convince an individual to fix the mess you created, and keep in mind that this individual will have a high bargain power, or do you think you are the only early-stage company with unmaintainable code?

---

I'll start by saying that vibe coding is a terrible name, and I'll not elaborate further. Extreme go horse is much cooler.

In my opinion, not all extreme go horse axioms are being fulfilled (yet), with that said, I'll only summarize axioms that we can easily find in vibe coding.

### I think, therefore it’s not XGH

Thinking is not necessary to see how this is closely related to vibe coding either. You just say what you want and let the AI do the heavy lifting. What could go wrong?

### There are 3 ways of solving a problem. The right way, the wrong way and the XGH way; which is exactly like the wrong one but faster.

This is my favorite so far. Is there something wrong? Just ask AI to rewrite that crap up until it get it right, you end up broke or you get a 429 in your face! It's faster than any development process you know anyways.

Also, I can only picture this:

![I'm stupid faster](https://storage.googleapis.com/blog-the-wall/public/stupid-faster.png)

### You’ll always need to do more and more XGH.

["6 months ago I was a 10x faster, now I'm a 100x faster"](https://youtu.be/IACHfKmZMr8?t=156)

You'll also need to debug 100x more bugs. Vibe coding requires you to just throw in the error and let the AI do the hard stuff [thinking].

Remember that your brain must be soap-like: no wrinkles at all!

Also, those bugs I just mentioned, they'll be solved 1000x faster, right?

### XGH is completely reactive.

As expected, of course vibe coding is reactive. You just feed your code into AI without analyzing it, you'll only see bugs when they happen, otherwise, they don't exist. In fact, don't even think adding observability to your application. Better yet, DON'T THINK AT ALL.

### In XGH anything goes.

![All wrong](https://storage.googleapis.com/blog-the-wall/public/all-wrong.png)

Of course everything goes ~wrong~

### You commit always before updating.

You don't need to uh... test things. You codebase now is a black box, after all, there is no such thing as garbage-in garbabe-out. If it works, it works, deploy it.

### XGH doesn’t have schedules.

Schedules aren't important because you can deliver everything on time with AI!!! [Check this _advanced_ vibe code technique](https://youtu.be/IACHfKmZMr8?t=140). And as the guy said shortly after: why not 3 screens with AI? Heck, why not 5?

We already doom scroll ourselves to tiredness everyday anyway. We gotta go fast. Are we suffering from SQL injection because AI used a deprecated escaping method from 20 years ago? Ask AI to fix that shit, the client can't wait. This kills the vibe!!

### There’s no refactoring just rework.

[EMBRACE THE VIBES BROOOOOO](https://youtu.be/IACHfKmZMr8?t=308). If you have a huge fucking system, you just ask it to rewrite the whole thing, right? In fact, rewrite it in Rust, that I'll solve our latency issues as well!

### XGH is anarchic.

So is any code made by AI. Remember that "_in XGH anything goes_".

### "XGH is absolute"

See the axiom below.

### "XGH is not a fad"

[He said the same freaking phrase](https://youtu.be/IACHfKmZMr8?t=8). This is one of the reasons that I think this is a huge joke that I didn't get it.

At this point, XGH and vibe coding are parsimonious for me.

### XGH is not always WOP (workaround oriented programming).

We saw this earlier, workarounds require thinking, and require somewhat refactoring stuff. Sorry, man. You'll have to prompt AI to do everything again.

### Don’t try to go against the tide.

This one is for the competent engineers. Everybody is just viiibing. Why are you worrying about testable and maintainable code? For every well though line you add, there are 5 agents throwing dirt at the fan. Just quit it! You are ruining the vibe.

### XGH is not dangerous until you see some order in it.

Maybe this one shouldn't be here, after all, your codebase is now a black box, so you don't see a thing.

---

I'll close with two Brian Kernighan's phrases, dated back in the 70's and still relevant:

_Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it._

_Controlling complexity is the essence of computer programming._

y'all know what I'm trying to say here.

---

Okay, so final countdown: vibe coding checks 14 out of 22 axioms. We still need to accomplish:

- Be ready to jump ship or blame someone else when it goes down.
- Be authentic. XGH doesn’t follow patterns.
- Always believe in improvement promises.
- XGH is your bro. But it’s vengeful.
- If it’s working don’t bother.
- Tests are for pussies.
- Be used to the ‘living on the edge’ feeling.
- The problem is only yours when you name is on the code docs.

We are almost there. In truth, some of them are very tied to vibe coding, I'm just lazy to write more stuff right now. Maybe I should assign an AI to write it for me.

Apart from that, there isn't enough millions of dollars and wasted energy injected in AI, I still can breathe fresh air. C'mon silicon valey guys!!

---

To be fair, [I have to give credit to the most honest sentence in the whole video right here, with a slight correction](https://youtu.be/IACHfKmZMr8?t=1025): vibe coding (formally extreme go horse) MIGHT be SOMEWHAT useful to get from 0 to 1, if it's not, just hire someone or learn to code, goddamn it. Beyond that, I wouldn't rely on it.

Additionally, [they said that reading and spotting bad code is a relevant skill for vibe coding](https://youtu.be/IACHfKmZMr8?t=1303). But let's be honest, they are trying really hard to automate code. Don't get me wrong, it's interesting to see the crazy stuff that is coming out of it, but AI isn't really the sharpest tool in the shed right now.

Besides that, the amount of money injected into "vibe coding" makes me fear that this is becoming a real thing.

I think this concept will fall over very soon.

I hope.
