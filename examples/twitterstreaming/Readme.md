# Overview
This example creates a simple JSON table within the Oracle Database and then streams tweets into it using [Python](http://www.python.org)

# Prerequisites
* Oracle Database 12.1.0.2+
* [Python 3.4+](http://www.python.org)
* [cx_Oracle 1.5.3+](http://cx-oracle.sourceforge.net/)
* [tweepy 3.3+](http://www.tweepy.org/)

# Usage
    Usage: stream.py [-h] [-batch [BATCH]] [-track [TRACK]] [-lang [LANG]]
    
    Optional arguments:
      -h, --help      show this help message and exit
      -batch [BATCH]  Database insert batch size
      -track [TRACK]  Track tweets based on a list of comma separated values
      -lang [LANG]    List of comma spearated tweet languages (en=English, de=German, fr=French, nl=Dutch, ...
