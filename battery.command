#!/usr/bin/env python

import os, time

#-------------------------------------------------------------------------------------------------------------

def battery_function():
	battery_file = open('battery_info.txt', 'r') # traverse file for reading ('r' mode)
	battery_string = '' # empty string to append letters from file since contents are un-indexable
	for x in battery_file:
		for y in x:
			battery_string += y
	battery_file.close()
	return battery_string

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def battery_helper():
	for x in range(len(battery_string)): # traverse through string until '%' is found
		if battery_string[x] == '%':	
			temp = x-2 # assuming percent is double-digit
			num = int(battery_string[temp:x])
			print(num) # output for visual check	
			return num
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def charging_function():
	charging_file = open('charging_status.txt', 'r') # traverse file for reading ('r' mode)
	charging_string = '' # empty string to append letters from file since contents are un-indexable
	for a in charging_file:
		 for b in a:
			charging_string += b
	charging_file.close()	
	print(charging_string)
	return charging_string

#-------------------------------------------------------------------------------------------------------------

while True:
	time.sleep(5) # wait every five seconds to check battery status
	os.system('pmset -g batt > battery_info.txt') # macOS command write battery info to external file
	os.system('pmset -g ps > charging_status.txt') # macOS command write charging status info to external file	

	battery_string = battery_function()
	charging_string = charging_function()[0:32]	
	num = battery_helper()

	if charging_string == "Now drawing from 'Battery Power'": # run warnings only when non-charging mode
		print('here')
		if (num <= 20): # if battery percentage is or below 20%, notify with sound and put to sleep
			while True:
				os.system('afplay /System/Library/Sounds/Sosumi.aiff')
				charging_string = charging_function()
				if charging_string != "Now drawing from 'Battery Power'":
					break
				time.sleep(1)
	else:
		if (num >= 80): # if battery percentage is or above 80%, notify with sound and put to sleep
			while True:
				os.system('afplay /System/Library/Sounds/Sosumi.aiff')
				charging_string = charging_function()
				if charging_string == "Now drawing from 'Battery Power'":
					break	
				time.sleep(1)

