import json
import sys


def extract_offboard_ip(obj):
    containers = obj[0]["Containers"]
    for key in containers:
        container = containers[key]
        if container["Name"] == "offboard_computer":
            ip4addr = container["IPv4Address"]
            # ipv4addr looks like "xxx.xxx.xxx.xxx/xx" remove after slash to get ip
            ip4addr = ip4addr.split("/")[0]
            return ip4addr



def main():
    infile = sys.stdin.read()
    obj = json.loads(infile)
    print(extract_offboard_ip(obj))


if __name__=="__main__":
    main()
