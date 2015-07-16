# Overview
This example creates a simple JSON table within the Oracle Database and then streams tweets into it using [Python](http://www.python.org). In order for it to work you have to have a twitter account and setup a twitter application.

# Prerequisites
* Oracle Database 12.1.0.2+
* [Python 3.4+](http://www.python.org)
* [cx_Oracle 5.1.3+](http://cx-oracle.sourceforge.net/)
* [tweepy 3.3+](http://www.tweepy.org/)

# Usage
    Usage: stream.py [-h] [-batch [BATCH]] [-track [TRACK]] [-lang [LANG]]

    Optional arguments:  
      -h, --help      Show the help message of the program and exits  
      -batch [BATCH]  The INSERT statement batch size (default 100). The program will execute a batch of <N> INSERTS    at once followed by a commit. It is recommended to run with the default value or even a higher batch size for the sample stream.  
      -track [TRACK]  Track tweets based on a list of comma separated values. These values can be anything including hash tags. The track list is case insensitive.   
      -lang [LANG]    List of comma spearated tweet languages (en=English, de=German, fr=French, nl=Dutch, ...
## Sample streaming
You can easily stream from the [Twitter stream](https://dev.twitter.com/streaming/public) by not providing any of the optional arguments. However, you may want to provide a list of languages to stream via the `-lang` argument.

### Examples

#### Example 1: Stream from public stream with increased batch size
    [oracle@gvenzl-virtual stream]$ python3 stream.py -batch 1000
    1000 tweets loaded.
    1000 tweets loaded.
    1000 tweets loaded.
    1000 tweets loaded.
    1000 tweets loaded.
    ^C
    Good bye!

#### Example 2: Stream all tweets in English and German from the public stream
    [oracle@gvenzl-virtual stream]$ python3 stream.py -lang "en,de"
    100 tweets loaded.
    100 tweets loaded.
    100 tweets loaded.
    100 tweets loaded.
    100 tweets loaded.
    ^C
    Good bye!

## Filter streaming
You can filter your stream by providing a list of filters via the `-track` argument. As the filtered tweets will potentially be a lot fewer than the unfiltered public stream, it is recommended to reduce the batch size in order to have the tweets persisted sooner.

### Examples
#### Example 1: Stream all tweets that include "Java", batch size 10
    [oracle@gvenzl-virtual stream]$ python3 stream.py -track Java -batch 10
    10 tweets loaded.
    10 tweets loaded.
    10 tweets loaded.
    ^C
    Good bye!
#### Example 2: Stream all tweets that include "Java" and "Programming", batch size 1
    [oracle@gvenzl-virtual stream]$ python3 stream.py -track "Java,Programming" -batch 1
    1 tweets loaded.
    1 tweets loaded.
    1 tweets loaded.
    1 tweets loaded.
    1 tweets loaded.
    ^C
    Good bye!

# Twitter setup
1. Go to [Twitter](http://www.twitter.com) and create an account
2. Go to [Twitter apps](http://apps.twitter.com) and click on `Create New App`
3. Fill in the details and hit `Create your twitter application`.
4. Click on the `Access Keys and Tokens` tab on top of the application. You will see your consumer key and consumer secret there.
5. Scroll down on the `Access Keys and Tokens` tab and click on `Create my access token`. The page will refresh and you will now see some values for your access key and secret.
6. Put your detalis into the Python script and run it.
