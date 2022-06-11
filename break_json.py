import sys
import json

# break up a column based json
# that is, we have { field1: { id: stuff ... }, field2: { id: stuff ... } ... }
# and we want each field's data in a separate file as ndjson

def main():

    jo = json.load(sys.stdin)
    
    Ka = jo.keys()

    for ka in Ka:
        jo[ka]
    Ki = jo["_id"].keys() # get all the level 2 keys
    d = { ki: { ka: jo[ka][ki] for ka in Ka } for ki in Ki } 
    print(json.dumps(d))

if __name__ == "__main__":
    main()
