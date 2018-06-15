#!/usr/bin/env python3

import xml.etree.ElementTree as et
import sys

def xmlparse(fn, tag):
    tree = et.ElementTree(file=fn)
    root = tree.getroot()
    for child in root:
        for grandchild in child:
            if grandchild.tag == tag:
                print(grandchild.text)
                break


if __name__ == "__main__":
    a = sys.argv
    if a[2] == 't':
        tag = '{http://purl.org/dc/elements/1.1/}title'
    else:
        tag = '{http://purl.org/dc/elements/1.1/}creator'
    xmlparse(a[1], tag)


