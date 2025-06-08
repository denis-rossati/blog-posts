# RSS is cool

I constantly wonder about how I consume stuff. This is a topic I can talk about for quite some time, but I'll do my best to keep it short, at most the personal experience part that I usually write on these blog posts.

We have several channels that we consult day to day, but I think we can agree that most of those channels are social media: Reddit, Facebook, X (ugh, terrible name), etc.

Personally, I don't like much how I need to be careful to not pollute my feed. Anytime I need to click some link that I know it's not what I'm used to consume, I care to open it on incognito window. But even then, we cannot escape certain types of personalization, like localized content, device fingerprint, or sometimes weird behavioral patterns, like how you scroll, how much time you spend reading something, etc.

Make no mistake, part of my job is to automate things, but nonetheless, I value manual effort more often than not. To find an interesting community organically rather than being spoon-fed is more pleasing. Specially when what is being fed  these days is not very tasty. Of course, this is anecdotal, but it's my impression.

## Straight to the point

I've been feeling more and more the constant need to avoid social media and spoon-fed content and look more into personal websites and journals, like this very blog. Maybe because I'm hosting one right now.

I get bothered very quickly by having thousands of tabs on my browser, so I abuse a lot of bookmarks and favorite pages, but they lack update systems. Every week or so I pick some random site and see what they are up to. But this is so time-consuming. I wonder if we had a Really Simple Syndication so that I can feed my newborn content, and it would notify my readers...

<sub>By the way, a lot of websites go offline fairly quickly; I discovered this small yet useful manifesto: [this page is designed to last](https://jeffhuang.com/designed_to_last/). I'm going to write about it sometime and how I plan to make my page to last at least 10 years.</sub> 

## RSS

RSS is a Really Simple Syndication. Syndication might not be a familiar word, but in context, to syndicate means to distribute something in a broadcast manner. This is exactly what RSS is: someone publish something, and subscribers receive the published thing. Really simple, huh? ** wink **

"How do I publish stuff, and how I consume stuff?" I heard you ask.

It cannot get simpler: publish in an RSS feed is to update a public XML file. To consume an RSS feed is to read that public file from time to time.

There are some rules regarding RSS, and there are multiple versions of the specification. I'll not cover them, as they really are simple (I'm dumb as a leaf of grass. So if I understood, I'm sure you can understand it too), anyway, you consult them [here](https://cyber.harvard.edu/rss/rss.html).

> One curious/historical tag is the \<enclosure\>. Back in the Y2K, loading media was expensive as stated in [this use-case](https://www.rssboard.org/rss-enclosures-use-case): _The wait is longer than the video. (In other words I have to wait two minutes for ten seconds of video.)_. This tag is to load media ahead so you don't need to wait, as said in the text "_The quality is limited by the size of my local disk, not by the capacity of my connection_". Today seems to be the opposite, I often have to delete some files to download others.

---

As simple as RSS is, different publishers use it in different ways. For example, a simple blog as mine, only needs one RSS, and it would probably have one item at a time. But publishers that have constant stuff to broadcast, with several categories, can have multiple RSS feeds, like NY1:


[![NY1 RSS feed](https://cdn.denis.my/assets/ny1-rss-feed.png)](https://ny1.com/nyc/all-boroughs/rss)

Let's see the local headline RSS, and check what a professional RSS looks like:


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

First thing I ask myself is how they keep the feed updated. They have a lot of news to share, but RSS must be lightweight, so it seems like they keep only the 100 newest news in the RSS.

They use RSS 2.0, good. [I've read somewhere](https://www.w3schools.com/xml/xml_rss.asp#:~:text=Is%20RSS%20a%20Web%20Standard%3F) that less than 25% of RSS feeds use 2.0 specifications.

They seem to use a generator as it's shown in the \<generator\> tag. My blog, though, don't have the same update frequency as they have, so I rather update it manually. But parsing an XML, adding an item and removing the old one is no challenge.

Other tags aren't that interesting, so I'll jump straight to the items.

We can already spot a tag that isn't part of the RSS 2.0 specification, that is the \<image\> and the \<protected\>. The standard is really customizable.

The ticker seem like another custom tag, I think it's those lower TV headlines that scroll horizontally.

I'm missing a GUID tag, they are usually used in RSS aggregators so they know which items were already notified to users, so they don't are spammed.

---

## My use-case

Honestly, this website does not need an RSS: I don't update this very often, and I don't have readers patiently waiting for me to write stuff. But I do things for fun.

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

