#!/bin/bash
for ((threads=2; threads<=30; threads++));
do
    ./mandelbrot -v 2 -t "$threads" | tail -n 1
done