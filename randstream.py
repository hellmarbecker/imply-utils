import time
import random
import json


def bimodal(m1, m2, s, p):

    if random.random() <= p:
        m = m1
    else:
        m = m2
    return random.gauss(m, s)


def main():
 
    distr = {
        'A': { 'fn': random.gauss,       'param': (10000, 2000) },
        'B': { 'fn': random.gauss,       'param': (10000, 10000) },
        'C': { 'fn': random.expovariate, 'param': (0.0001,) },
        'D': { 'fn': bimodal,            'param': (10000, 50000, 2000, 0.8) },
    }
    for i in range(0, 10000):
        grp = random.choices('ABCD', cum_weights=(0.50, 0.75, 0.90, 1.00), k=1)[0]
        rec = {
            'tn': time.time() - 10000 + i,
            'cn': grp,
            'rn': distr[grp]['fn'](*distr[grp]['param'])
        }
        print(json.dumps(rec))

if __name__ == "__main__":
    main()

