#!/bin/bash

#==================================#
#  This file is a local installer  #
#==================================#

rsync -avh --force ./climath ~/.Wolfram/Applications/ --delete
rsync -avh --force ./climath ~/.Mathematica/Applications/ --delete

exit 0
