import json, random, time

# Helper variables holding some example data to generate JSON from
firstName = [ "John", "Markus", "Gerald", "Adrian", "Dominik", "Andrew", "David", "Edward", "Martin", "Penny" ]
lastName = [ "Nangle", "Gratzer", "Venzl", "Richmond", "Ashley", "Bond", "Smith", "Stadler", "Avril", "Jones" ]
age = [ 29, 43, 48, 42, 21, 32, 56 ]

def generateJSON():
    """Generate random JSON document"""
    return json.dumps({ "firstName": firstName[random.randint(0, len(firstName)-1)],  
                        "lastName": lastName[random.randint(0, len(lastName)-1)],
                        "age": age[random.randint(0,len(age)-1)] })

while True:
    #TODO: Get DB connection
    #TODO: Insert data
    print(generateJSON())
    # Sleep for 2 seconds
    time.sleep(2)