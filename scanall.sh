#!/usr/bin/env bash

END=254
for i in $(seq 1 $END); do
    nc -vz -w1 $1.$i $2;
done
