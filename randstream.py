import time
import random
import json

def main():
 
    while True:
        rec = {
            'tn': time.time(),
            'cn': random.choices('ABCDE', cum_weights=(0.50, 0.75, 0.82, 0.91, 1.00), k=1)[0],
            'rn': random.gauss(0.0, 1.0)
        }
        print(json.dumps(rec))
        time.sleep(0.1)

if __name__ == "__main__":
    main()

