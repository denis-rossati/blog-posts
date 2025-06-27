# A beginner friendly timing attack explanation


![Timing attack compared to regular brute force attack](https://cdn.denis.my/assets/timing-attack-comparison.gif)


My mind is still blown. I mean, this is one of the things that you know it's possible, but who would have the time to test it out?

This is a timing attack. It uses the time used to process something as a hint to whether you are in the right track to exploit something.

The gif above shows a didactic case, both of them work with the same "validation" function:

```ts
async function checkPassword(inputPassword: string): Promise<boolean> {
    const inputChars = inputPassword.split('');

    for (let index = 0; index < password.length; index++) {
        await sleep(requestMedian); // This is important, we'll get back to this later

        const expectedChar = password[index];
        const actualChar = inputChars[index];

        if (expectedChar !== actualChar) {
            return false;
        }
    }

    return true;
}
```

The brute force is a dumb brute force, it works hard:

```ts
(async function main() {
    const possibleChars = ['a', 'b', 'c', 'd', 'e']; // Simplified character set, this actually covers a-z, - and 0-9
    const attemptsQueue: string[] = [''];

    while (attemptsQueue.length > 0) {
        const currentGuess = attemptsQueue.shift();

        if (currentGuess === undefined) {
            continue;
        }

        for (const char of possibleChars) {
            const nextGuess = currentGuess + char;

            if (await checkPassword(nextGuess)) { // Found password!!
                return;
            }

            attemptsQueue.push(nextGuess);
        }
    }
})();
```

The timing attack works smarter:

```ts
(async function main() {
    const guessedPassword: string[] = [];
    const possibleChars = ['a', 'b', 'c', 'd', 'e']; // Same as before
    
    let charIndex = 0;

    while (true) {
        if (charIndex >= possibleChars.length) {
            charIndex = 0;
        }

        const trialChar = possibleChars[charIndex];
        const trialPassword = [...guessedPassword, trialChar].join('');

        const expectedTime = (guessedPassword.length + 1) * requestMedian;

        const startTime = Date.now();

        if (await checkPassword(trialPassword)) { // Found password!!
            return;
        }

        const endTime = Date.now();

        const elapsed = endTime - startTime;

        if (elapsed > expectedTime + 10) {
            guessedPassword.push(trialChar);
            charIndex = 0;
        } else {
            charIndex++;
        }
    }
})();
```

As we can see, there is nothing really special in the regular brute force. The function tries every possible char before adding a new field, and then it tries every combination, then adds another character, and so on, until one of the combinations matches the password.

The timing attack knows that each character comparison takes a while, and it uses this time window to its advantage, because more time spent on the processing suggests that you got a character right.


---


This is, of course, an exaggerated case. But it's totally feasible in regular apps.

You might know this, already, but string comparison don't have a constant time, and this is where the exploit lives.

Let's take the `libc`, which is used by GCC as an example. As of today (2025-06-12), it is implemented like this (not exactly, because this is an optimization for bytes aligned in memory, but it's easier to understand):

```c
static inline int
strcmp_aligned_loop (const op_t *x1, const op_t *x2, op_t w1)
{
  op_t w2 = *x2++;

  while (w1 == w2)
    {
      if (has_zero (w1))
        return 0;
      w1 = *x1++;
      w2 = *x2++;
    }

  return final_cmp (w1, w2);
}
```

This does not compare byte by byte as `w1` and `w2` might be 4 to 8 bytes at once. But it shows that string comparison is done piece by piece.

Exploiters will trace more or less the amount of time it takes to compare those strings, and if they get more of the string right, more time will be used!


## "Doesn't matter, because I'm protected by random latencies over the network >:)"

Oh if only we had a particular protocol that allow requests to sent in flight by the same TCP connection and consumed by the server simultaneously... 

I'm talking about HTTP/2, and besides, you never know when the attack comes from inside your server, right?

Of course, with enough calls to your endpoint, this could be brute-forced into HTTP/1.1 too, it would just be harder. There is a meaningful example in [this paper](https://eprint.iacr.org/2011/232.pdf), even though they did it on localhost and the latency issue would be more forgiving

```
The first scenario we considered consists of a collecting process running on the same host as the server process. The messages are exchanged over the OS TCP/IP stack using the localhost address on the loopback interface. In this scenario we successfully retrieved the server private key, even repeating the tests using different private keys, randomly generated using OpenSSL itself, and targeting both the OpenSSL 0.9.8o and 1.0.0a versions of the reference server.

(...)

Once verified that the attack is practical when run over the loopback interface on the same host of the attacked server, we performed the same attack in a slightly more complex network scenario: the attacker collects the signatures from a host connected to the same network switch of the server. The tests were run between two hosts residing in the same room in time frames with reasonably low network loads, trying to minimize the noise introduced by external causes in the time measures. 

(...)

The average rates of “false positives” in the filtered sets increases. (...) Regardless, a vulnerability exploitable to perform a successful attack from the same host where the targeted server is run poses a threat even for remote attacks. For example, in virtual hosting or cloud computing scenarios an attacker may be able to obtain access to run code on the same physical machine hosting the target server 
```

Last sentence describes my fears precisely, who can guarantee that the exploit will come from outside?

---

Before you go adding random timeout middlewares, rest assured this is a known and very researched exploit!

All we need to do is avoid exposing the passage of the time when comparing values (or any other thing, really). In typescript, for example, you can get around it quite easily by changing your regular `===` with `crypto.subtle.timingSafeEqual(a, b)`. While this is a non-standard extension to the Web Crypto API, it is already widely adopted with some [nice algorithms to choose from](https://www.w3.org/TR/webcrypto/#algorithm-overview).
