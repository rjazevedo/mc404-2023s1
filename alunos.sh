#!/bin/bash

iconv -f iso8859-1 -t utf-8 < MC404_A.csv | cut -d\; -f5,6 > mc404a.csv
iconv -f iso8859-1 -t utf-8 < MC404_E.csv | cut -d\; -f5,6 > mc404e.csv
