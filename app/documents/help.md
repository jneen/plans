## What is this, anyways?

Plans is a small, private, and dirt-simple social network.

Each user has a plan, which is essentially a big block of text where you can put anything you want, and it will only be visible to those who have accounts on plans.

## What is "planlove"?

In your plan, you can mention other people by their usernames.  For example, if I want to mention that I hung out with @jayferd, I would simply type

    I had an awesome time hanging out with \@jayferd.

and it would be transformed into this:

> I had an awesome time hanging out with @jayferd.

After mentioning @jayferd, you will appear in his planlove list when he next logs in.

## What is "finger"/"autofinger"?

Your autofinger list is a convenient way to keep track of people whose plans you want to follow.  If you finger @barretta, for example, his name will appear in your autofinger list the next time he updates his plan, and will disappear when you view his plan.

The list of people you have fingered is entirely private, and is not shared with anyone.  Feel free to finger/unfinger anyone as you please.

## Sweet!  How do I do fancy things with my plan?

Your plan is filtered through a text-to-html converter called "[markdown][]", which enables you to do a lot of nifty things.  You can read the documentation on their site, but here are a couple of basic examples.

[markdown]: http://daringfireball.net/projects/markdown/basics

**when you write**:

    use *asterisks* to make something italic, and **double asterisks** to make it bold.

    For lists of things, you can use

    * asterisks (*),
    * dashes (-),
    * plus signs (+)

**you get**:

> use *asterisks* to make something italic, and **double asterisks** to make it bold.
> 
> For lists of things, you can use
>
> * asterisks (*),
> * dashes (-),
> * plus signs (+)

**when you write**:

      Links are easy.  [This link](http://google.com) takes you to Google's homepage.  If you have really long links, you can use the footnote-style links, like [this][orangutans], which looks up a reference that you can put in anywhere in the document.

      [orangutans]: http://www.google.com/search?q=orangutans

**you get**:

> Links are easy.  [This link](http://google.com) takes you to Google's homepage.  If you have really long links, you can use the footnote-style links, like [this][orangutans], which looks up a reference that you can put in anywhere in the document.

[orangutans]: http://www.google.com/search?q=orangutans

Feel free to experiment however you want, there's no limit to how many times
you can change your plan.  You can also use the fancy "preview" beneath the
edit box, which requires javascript to be enabled in your browser.
