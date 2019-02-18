import json
import sys


def extract_gateway(obj):
    return obj[0]["IPAM"]["Config"][0]["Gateway"]

def main():
    infile = sys.stdin.read()
    obj = json.loads(infile)
    print(extract_gateway(obj))


if __name__=="__main__":
    main()
