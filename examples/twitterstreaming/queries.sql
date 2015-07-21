-- Count all the languages present in the sample data set.
SELECT t.tweet.lang, COUNT(1)
 FROM twitter t
  GROUP BY T.tweet.lang
   ORDER BY 2 DESC;

-- Show the first 10 tweets that do not have any language encoding present.
SELECT t.tweet
 FROM twitter t
  WHERE t.tweet.lang IS NULL
   FETCH FIRST 10 ROWS ONLY;

-- Count all the languages of the tweets that do have hashtags in them.
SELECT t.tweet.lang, count(1)
 FROM twitter t
  WHERE JSON_EXISTS(t.tweet, '$.entities.hashtags[*]')
   GROUP BY t.tweet.lang
    ORDER BY 2 DESC;

-- Show the tweet's language encoding and hashtags
SELECT t.tweet.lang, JSON_QUERY(t.tweet, '$.entities.hashtags[*].text' WITH WRAPPER) hashtags
 FROM twitter t
  WHERE JSON_EXISTS(t.tweet, '$.entities.hashtags[*]')
   ORDER BY 1;

-- Show the tweet that contains the hashtag "#Essex"
SELECT t.tweet.text
 FROM twitter t
  WHERE INSTR(t.tweet.text, '#Essex') > 0;
