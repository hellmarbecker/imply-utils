import csv
import json

def main():

    with open('./timeseries-result.csv', 'r') as csv_file:
        reader = csv.DictReader(csv_file)

        for row in reader:
            for k, v in row.items():
                print(k)
                print(json.dumps(json.loads(v), indent=2))


if __name__ == "__main__":
    main()
