import json
import time
from faker import Faker

fake = Faker()

def main():

    ts = time.time()
    for sid in range(10000):

        uid = fake.random_int(min=1, max=1000)
        pagesPerSession = fake.random_int(min=1, max=30)
        sessionLength = pagesPerSession * (1.0 + fake.random_int(min=1, max=100) / 50.0)
        
        emitRecord = {
            "timestamp" : ts,
            "uid" : uid,
            "sessionLength" : sessionLength,
            "pagesPerSession" : pagesPerSession
        } 
        print(json.dumps(emitRecord))

if __name__ == "__main__":
    main()
