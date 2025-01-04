#!/bin/bash

#==================================#
#  This file is a local installer  #
#==================================#

rsync -avh --force ./climath ~/.Wolfram/Applications/ --delete

exit 0
