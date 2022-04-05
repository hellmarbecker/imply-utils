import sys
import json

# transform a column based json
# that is, we have { field1: { id: stuff ... }, field2: { id: stuff ... } ... }
# and we want { id: { field1: ..., field2: ...  } }

def main():

    jo = json.load(sys.stdin)
    
    Ka = jo.keys()
    Ki = jo["_id"].keys() # get all the level 2 keys
    d = { ki: { ka: jo[ka][ki] for ka in Ka } for ki in Ki } 
    print(json.dumps(d))

if __name__ == "__main__":
    main()
