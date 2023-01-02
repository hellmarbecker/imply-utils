import json
import time
import random
from faker import Faker

maxUsers = 1000
maxSessions = 20000
fake = Faker()


def gauss_cut(m, s):

    result = random.gauss(m, s)
    if (result > 0.0):
        return result
    return 0.0


def bimodal(m1, m2, s, p):

    if random.random() <= p:
        m = m1
    else:
        m = m2
    return gauss_cut(m, s)


def main():

    distr = {
        'sessionLength' : {
            'A': { 'fn': gauss_cut,          'param': (1000, 200) },
            'B': { 'fn': gauss_cut,          'param': (1000, 1000) },
            'C': { 'fn': random.expovariate, 'param': (0.001,) },
            'D': { 'fn': bimodal,            'param': (1000, 5000, 200, 0.8) },
        },
        'pagesPerSession' : {
            'A': { 'fn': gauss_cut,          'param': (10,  2) },
            'B': { 'fn': gauss_cut,          'param': (10, 10) },
            'C': { 'fn': random.expovariate, 'param': (0.1,) },
            'D': { 'fn': bimodal,            'param': (10, 30, 2, 0.8) },
        }
    }


    segment = [ random.choices('ABCD', cum_weights=(0.50, 0.75, 0.90, 1.00), k=1)[0] for uid in range(maxUsers) ]

    ts = time.time() - 10 * 86400 # 10 days back
    for sid in range(maxSessions):

        uid = fake.random_int(min=0, max=maxUsers-1)
        seg = segment[uid]
        pagesPerSession = 1 + round(distr['pagesPerSession'][seg]['fn'](*distr['pagesPerSession'][seg]['param']))
        sessionLength = round(distr['sessionLength'][seg]['fn'](*distr['sessionLength'][seg]['param']), 2)
        
        emitRecord = {
            "timestamp" : int(round(ts)),
            "uid" : uid,
            "segment" : seg,
            "sessionLength" : sessionLength,
            "pagesPerSession" : pagesPerSession
        } 
        print(json.dumps(emitRecord))
        ts += fake.random_int(min=60, max=600)

if __name__ == "__main__":
    main()
