# RSS stands for Robot Sends Stuff

Well, actually it stands for Really Simple Syndication. Syndication might not be a familiar word, but in context, to syndicate means to distribute something in a broadcast manner. This is exactly what RSS is: publishers publishes something, and subscribers receive it. **R**eally **s**imple **s**tuff, huh? \*wink\*

"How do I publish stuff, and how I consume it?" I heard you ask.

It cannot get simpler: publishing to an RSS feed is to update an XML file. To consume an RSS feed is to read that public file from time to time.

There are some rules regarding RSS, and there are multiple versions of the specification. I won't cover them, as they really are simple (I'm not specially smart. So if I understood it, I'm sure you can too), anyway, feel free to consult them [here](https://cyber.harvard.edu/rss/rss.html).

> One curious/historical tag is the `<enclosure>`. Back in the early 2000s, loading media was expensive as stated in [this use-case](https://www.rssboard.org/rss-enclosures-use-case): _The wait is longer than the video. (In other words I have to wait two minutes for ten seconds of video.)_.
> This tag is used to load media ahead so you don't need to wait, as said in the text "_The quality is limited by the size of my local disk, not by the capacity of my connection_". Today seems to be the opposite, I often have to delete local files to download new ones.

---

It might be old, but honestly, its simplicity got me, and I think it's one of the few tools that does things right. Its simplicity got me easily, there is a simple set of rules that you can build around it with ease.

A simple blog lke mine, only needs one simple RSS file, and it would probably have one item at a time. Big publishers that have a constant need to broadcast stuff from various sources and categories can have multiple RSS feeds, like NY1:


[![NY1 RSS feed](https://cdn.denis.my/assets/ny1-rss-feed.png)](https://ny1.com/nyc/all-boroughs/rss)

---

But being bigger in demand doesn't mean it's complex. An untrained eye can open any RSS file and read it quite naturally. In fact, to better understand how everything is structured, let's check how professionals do it! This is the "Local Headlines" RSS feed from NY1:

```xml
<?xml version='1.0' encoding='UTF-8'?>
<rss version='2.0' xmlns:atom='http://www.w3.org/2005/Atom' xmlns:media='http://www.w3.org/2005/Media'>
  <channel>
    <atom:link rel='self' type='application/rss+xml' href='http://www.ny1.com/services/contentfeed.nyc|all-boroughs|news.landing.rss' />
    <title>NYC Headlines | Spectrum News NY1</title>
    <description>Check the latest New York City headlines and breaking news from NY1.</description>
    <link>http://www.ny1.com/nyc/all-boroughs/news</link>
    <docs>http://backend.userland.com/rss</docs>
    <generator>RSS.NET: http://www.rssdotnet.com/</generator>
    <item>
      <title>Dry finish to the weekend</title>
      <description>Sunday will be dry. </description>
      <image>
        <url>https://s7d2.scene7.com/is/image/TWCNews/mostly_cloudy_rain_shower_spring_new_york_city_nyc_ny_MattFriedman_033125</url>
      </image>
      <link>http://www.ny1.com/nyc/all-boroughs/weather/2020/07/04/new-york-city-all-boroughs-daily-forecast</link>
      <section>Weather Stories</section>
      <author>Spectrum News Weather Staff</author>
      <protected />
      <pubDate>Sun, 08 Jun 2025 11:04 AM EDT</pubDate>
      <ticker>Dry finish to the weekend</ticker>
    </item>
    <item>
      <title>Protesters clash with police outside NYC immigration courts</title>
      <description>Protesters angered by President Donald Trump's immigration policies attempted stop vehicles exiting the building they believed had detainees in them.</description>
      <image>
        <url>https://s7d2.scene7.com/is/image/TWCNews/NYC_26_Federal_Plaza_AP_20009669998969</url>
      </image>
      <link>http://www.ny1.com/nyc/all-boroughs/news/2025/06/08/protesters-clash-with-police-outside-nyc-immigration-courts</link>
      <section>CTV For Your Consideration</section>
      <author>Joseph Konig, Samantha Liebman</author>
      <protected />
      <pubDate>Sun, 08 Jun 2025 10:55 AM EDT</pubDate>
      <ticker>Protesters clash with police outside NYC immigration courts</ticker>
    </item>
    <!-- Other 98 items... -->
  </channel>
</rss>
```

This is quite readable, isn't it? We have the RSS version, the feed title, description, docs, link... Everything is very descriptive. But I'll add some thoughts that emerge from me when I read this.

One question I ask myself is how they keep the feed updated. They have a lot of news to share, but RSS must be lightweight, so it seems like they keep only the 100 newest news in the RSS.

They use RSS 2.0, good. [I've read somewhere](https://www.w3schools.com/xml/xml_rss.asp#:~:text=Is%20RSS%20a%20Web%20Standard%3F) that less than 25% of RSS feeds use 2.0 specifications. Don't know if this is accurate... probably not, but might be a similar number.

They seem to use a generator as it's shown in the `<generator>` tag. My blog, though, doesn't have the same update frequency as they have, so I'd rather update it manually. If someday I feel the need to automate it, parsing an XML, adding an item and removing the old one is no challenge.

Other tags are so self-explanatory that they aren't that interesting, so I'll jump straight to the items.

We can already spot a tag that isn't part of the RSS 2.0 specification, that is the `<image>` and the `<protected>`. The standard is really customizable.

The `<ticker>` seems like another custom tag, I think it's those lower TV headlines that scroll horizontally.

I'm missing a GUID tag, they are usually used in RSS aggregators so they know which items were already notified to users, so they aren't spammed.

## My use-case

Honestly, this website does not _need_ an RSS: I don't update it often, and I don't have readers waiting on the edge of their seats. But I do things for fun.

At my scale, I'm better off just doing things manually right now, but if I really start to write like a maniac, I'll probably trigger a GitHub Action at my [post repository](https://github.com/denis-rossati/blog-posts) to update the XML.

Check out my very first version of my RSS feed:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
    <channel>
        <title>The Wall</title>
        <link>https://denis.my</link>
        <description>A Really Simple Dev Journal.</description>
        <language>en-us</language>
        <lastBuildDate>Sun, 08 Jun 2025 17:34:10 GMT</lastBuildDate>
        <pubDate>Sun, 08 Jun 2025 17:34:10 GMT</pubDate>

        <item>
            <title>RSS is cool</title>
            <link>https://denis.my/blog/posts/33aa7da0-3f9a-fa83-aa5e-beecd923d110</link>
            <description>IMO, creating your own feed is more fun.</description>
            <author>denis.rossatiramos@gmail.com (Denis Rossati)</author>
            <pubDate>Sun, 08 Jun 2025 17:34:10 GMT</pubDate>
            <guid isPermaLink="true">https://denis.my/blog/posts/33aa7da0-3f9a-fa83-aa5e-beecd923d110</guid>
        </item>
    </channel>
</rss>
```

Yes, this whole post was just a call so I can ask you all to subscribe to my feed :)

### How to consume feeds?

You'll need an aggregator. They are nothing more than a program that visits the RSS files periodically, and then check if there are new items on them.

When I knew about them, I asked myself two questions:

"How often should I check the feeds?"

and

"How do they know which items were already seen?"

And the answer for those two are: it's configurable.


The first one is straightforward: from time to time, check the files, then run a bunch of criteria to know if I should notify the user about some item.

This leads us to the second question. The answer can range from "just notify every single item everytime you check the RSS file" from "...it's complicated". Mainly because the tags that would let us know which posts were already notified are optional, basically, a feed item need either a `<title>` or a `<description>`, and a `<link>`. Personally, I'd be happy to use a group of tags with some priority ranking as a cursor (like `<pubDate>` or `<guid>`), and, in last case, the `<link>` itself.

Luckily, you don't need to worry about implementing your own aggregator as there are a lot of open-source alternatives. I use [fresh RSS](https://github.com/FreshRSS/FreshRSS) because it's [REALLY simple to set up](https://github.com/FreshRSS/FreshRSS#manual-install) (from a developer perspective), it's open-source and, mainly, because it is self-hosted.

Of course, this is probably too much for non-tech humans. Don't worry, just throw "RSS [your browser name here] extension" and I'm sure you'll find some plug-and-play alternatives :)

## Why does this even matter?

> Rant time. I've decided to include this one at the end rather than the beginning. I think it'll look better and spare readers from garbage writing.

I often think about how I consume content. This is a topic I can talk about for quite some time. We use several channels daily, but I think we can agree that most of them are social media: Reddit, Facebook, X (ugh, terrible name), etc. Personally, I don't like having to be careful to not pollute my feed. Anytime I need to click some link that it probably isn't something I'd consume, I care to open it on incognito window. But even then, it's hard to escape personalization, like localized content, device fingerprint, or sometimes weird behavioral patterns, like how you scroll, how much time you spend reading something, etc.

Make no mistake, part of my life is to automate things, but nonetheless, I value manual effort more often than not. Actually, I even praise the manual effort to automate things. With that said, finding an interesting community organically is far more satisfying than being spoon-fed, specially when what is being fed these days is not very tasty. Of course, this is anecdotal.

I've been feeling more and more need to avoid social media and spoon-fed content and look more into personal websites and journals, like this very blog. Maybe because I'm hosting one right now.

One problem, though, is that they all lack a standardized notification system that we much appreciate on regular social media. If I only had a Really Simple Syndication so that I can be notified whenever people that _really_ interest me post something new...

Being notified is not the only reason I use RSS for. Sometime ago I maintained a really large bookmarks bar, easily a few hundreds, and the nature of the internet is to be ephemeral, because of that, a lot of websites get outdated really quickly, this could be because someone changed their domain, the site was discontinued, whatever. So I ended up with a large bookmark bar, and I didn't even knew which blogs were still online or not.

_By the way, regarding the ephemeral web issue, I discovered this interesting manifesto: [this page is designed to last](https://jeffhuang.com/designed_to_last/). I'm going to write about it sometime._

RSS can fix this problem too. When they do their usual round trip, it can check for feeds that weren't updated in a while, and prompt the user for a manual check, or if they want to dismiss that feed permanently. It won't the archival aspect of the problem, since whenever a site goes offline, its content is lost if it's not designed to last/it's not archived.
