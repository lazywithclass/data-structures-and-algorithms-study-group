#!/usr/bin/env python
#title           :hanoi.py
#description     :Recursive implementation of the game Towers of Hanoi.
#author          :jootse84
#date            :2017-02-15
#version         :0.0
#usage           :python pyscript.py
#notes           :
#python_version  :2.6.6  
#==============================================================================

def printStatus():
    print(source, helper, target)

def hanoi(source, helper, target, tower):
    if tower is 1:
        # base case: nothing to do
        if source:
            printStatus()
            target.append(source.pop())
    else:
        # recursive case
        # move tower of size n - 1 to helper
        hanoi(source, target, helper, tower - 1)
        # move last disk from source to target 
        hanoi(source, helper, target, 1)
        # move tower of size n-1 from helper to target
        hanoi(helper, source, target, tower - 1)

source = [7,6,5,4,3,2,1]
helper = []
target = []
hanoi(source, helper, target, len(source))

printStatus()
