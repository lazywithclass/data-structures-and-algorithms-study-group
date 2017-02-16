#!/usr/bin/env python
# -*- coding: utf-8 -*-

input = map(int, raw_input('> ').strip().split(' '))

print '=>    ', input

n = len(input)

for i in range(n-1, 0, -1):
    swapPosition = 0
    for j in range(1, i + 1):
        if input[j] > input[swapPosition]:
            swapPosition = j

    temp = input[i]
    input[i] = input[swapPosition]
    input[swapPosition] = temp
    print '=>    ', input

print 'final ', input