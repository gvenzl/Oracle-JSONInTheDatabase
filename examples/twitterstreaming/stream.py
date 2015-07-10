from tweepy import OAuthHandler
from tweepy import Stream
from tweepy.streaming import StreamListener
import cx_Oracle

db_host = "<host name>"
db_port = "1521"
db_name = "<DB name>"
db_batchSize = 100

db_user = "<database user>"
db_password = "<database password>"
db_table = "TWITTER"       # Define your table name where you would like to store your tweets
db_col   = "tweet"         # Define the table name column where you would like to store your tweets

twitter_consumer_token = "<Consumer token>"
twitter_consumer_secret = "<Consumer secret>"
twitter_access_token = "<Access token>"
twitter_access_secret = "<Access secret>"

class DBLoader:
    """Loads data into the database"""
    def __init__(self):
        self._conn = cx_Oracle.connect(db_user, db_password, cx_Oracle.makedsn(db_host, db_port, service_name=db_name))
        # Setup table
        self.setup()
        
        # Loading statement
        self._cursor = self._conn.cursor()
        self._cursor.prepare("INSERT INTO " + db_table + " (" + db_col + ") VALUES (:tweet)")

        # Tweets array
        self._tweets = []
        
    def setup(self):
        cur = self._conn.cursor()
        cur.execute("SELECT COUNT(*) FROM USER_TABLES WHERE TABLE_NAME = :tbl_name", tbl_name=db_table)
        result = cur.fetchall()
        # Table count returns 0, we need to create the table first
        if (result[0][0] == 0):
            cur.execute("CREATE TABLE " + db_table + " (" + db_col + " CLOB CONSTRAINT " + db_table + "_valid_json CHECK (" + db_col + " IS JSON))")
            print("New table created: " + db_table)
        
    def load(self, data):
        self._tweets.append(data)
        
        # If inserts reach commit size issue a commit
        if (len(self._tweets) == db_batchSize):
            self._persist()

    def _persist(self):
        # Make this use executemany instead of execute
        for tweet in self._tweets:
            var = self._cursor.var(cx_Oracle.CLOB)
            var.setvalue(0,tweet)
            self._cursor.execute(None, tweet=var)
        self._conn.commit()
        self._tweets.clear()
    
class TweetsListener(StreamListener):
    """TweetsListener listens to incoming tweets and loads them into the DB.

        Once data is received from the stream the listener simply loads them into the database."""

    def __init__(self):
        self.loader = DBLoader()
    
    def on_data(self, data):
        self.loader.load(data)
        return True

    def on_error(self, error):
        print("Error: " + error)
        return True

# Setup the authentication handler
auth = OAuthHandler(twitter_consumer_token, twitter_consumer_secret)
auth.set_access_token(twitter_access_token, twitter_access_secret)

# Connect to the Twitter stream
stream = Stream(auth, TweetsListener(), Timeout=None)
stream.sample()
