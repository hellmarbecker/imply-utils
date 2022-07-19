import csv
import json

def main():

    with open('./timeseries-result.csv', 'r') as csv_file:
        reader = csv.DictReader(csv_file)

        for row in reader:
            print(row)


if __name__ == "__main__":
    main()
