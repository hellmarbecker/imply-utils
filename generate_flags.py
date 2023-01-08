import json
import time
from faker import Faker

maxRecords = 20000
fake = Faker()
flagsOrNot = [ "f1", "f2", "f3", "f10", "f1f", "ff1", "abc" ];

def main():

    ts = time.time() - 10 * 86400 # 10 days back
    for id in range(maxRecords):

        emitRecord = {
            "timestamp" : int(round(ts)),
            "quantity" : fake.random_element(elements=('a', 'b', 'c', 'd')),
            "value" : fake.random_number(digits=3) / 100.0,
        }
        emitRecord.update( {
            k : fake.boolean() for k in flagsOrNot
        } )
        
        print(json.dumps(emitRecord))
        ts += fake.random_int(min=1, max=60)

if __name__ == "__main__":
    main()
