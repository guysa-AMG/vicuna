from argparse import ArgumentParser
from discord import send
parser = ArgumentParser()

parser.add_argument("-m","--message")
parser.add_argument("-s","--status",default="successfull")


def main(arg):
    send(arg.message)
    


if __name__ == "__main__":
    arg = parser.parse_args()
    main(arg)
