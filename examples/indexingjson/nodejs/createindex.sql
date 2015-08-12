-- NOTE: Run this as the STREAMER user and pick the index you want to create.
--       By default the script will build the automatically synchronized index

-- Create a synchronous index
--CREATE INDEX tweet_ft_idx_01 ON TWITTER (tweet)
--  INDEXTYPE IS CTXSYS.CONTEXT
--  PARAMETERS ('section group CTXSYS.JSON_SECTION_GROUP SYNC (ON COMMIT)');

-- CREATE an automatically synchronized index for every 10 minutes that runs with PARALLEL 4
CREATE INDEX tweet_ft_idx_01 ON TWITTER (tweet)
  INDEXTYPE IS CTXSYS.CONTEXT
  PARAMETERS ('section group CTXSYS.JSON_SECTION_GROUP SYNC (EVERY "")');
  
-- Create an asynchronous index
--CREATE INDEX tweet_ft_idx_01 ON TWITTER (tweet)
--  INDEXTYPE IS CTXSYS.CONTEXT
--  PARAMETERS ('section group CTXSYS.JSON_SECTION_GROUP SYNC (MANUAL)');
