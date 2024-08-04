#!/bin/bash

#==================================#
#  This file is a local installer  #
#==================================#

rsync -avh --force ./climath ~/.Mathematica/Applications/ --delete

exit 0
