# Exosuit

Deploying Rails to AWS is a pain in the ass. Simply deploying a "hello, world" Rails app to EC2 can take hours of intense mental effort and trial-and-error.

Heroku makes deployment easy, but if you use Heroku, you're not using AWS, you're using Heroku. Heroku puts up a wall between you and your AWS infrastructure, meaning you can't manage your AWS infrastructure directly. Plus Heroku is expensive.

What if there were something in between? What if there were a tool that provided the dead-simple ease of use Heroku provides, but didn't put up a wall between you and your AWS infrastructure?

This is the aim of *Exosuit*. Exosuit is a free, open source tool that lets you deploy Rails applications to AWS easily, quickly, and simply.

## Core beliefs

- I should be able to deploy a fresh Rails application to AWS with a single command and be all set within seconds - not hours.
- Exosuit's documentation should be written in plain language and easy to understand, even for a beginner (unlike AWS!).
- Exosuit's command-line interface should be intuitive and provide helpful, informative error messages when things go wrong.

## Development status

As of this writing (September 2019), Exosuit is only at the idea stage. I've written a tiny, tiny amount of code for it. You can feel free to try to take it for a spin but you should set your expectations very low.
