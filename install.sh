#!/bin/bash

#==================================#
#  This file is a local installer  #
#==================================#

rsync -avh --force ./NoMoreNotebooks ~/.Wolfram/Applications/ --delete
rsync -avh --force ./NoMoreNotebooks ~/.Mathematica/Applications/ --delete

exit 0
