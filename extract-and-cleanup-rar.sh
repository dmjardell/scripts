#!/bin/bash
rar e $1  && find . -regex ".*\.r[0-9]+" -exec rm -f {} \;
