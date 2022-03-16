import time
import random
import json

def main():
 
    weights = {
        'A': (10000, 1000),
        'B': (10000, 2000),
        'C': (10000, 5000)
        'D': (20000, 2000),
        'E': (25000, 2500),
    }
    while True:
        grp = random.choices('ABCDE', cum_weights=(0.50, 0.75, 0.82, 0.91, 1.00), k=1)[0]
        rec = {
            'tn': time.time(),
            'cn': grp,
            'rn': random.gauss(*weights[grp])
        }
        print(json.dumps(rec))
        time.sleep(0.1)

if __name__ == "__main__":
    main()

