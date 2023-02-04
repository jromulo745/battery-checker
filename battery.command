#!/usr/bin/env python3

import os, time

os.system('osascript -e \'tell application "Terminal" to set miniaturized of window 1 to true\'')

#-------------------------------------------------------------------------------------------------------------

def battery_function():	
	os.system('pmset -g batt > battery_info.txt') # macOS command write battery info to external file
	battery_file = open('battery_info.txt', 'r') # traverse file for reading ('r' mode)
	battery_string = '' # empty string to append letters from file since contents are un-indexable
	for x in battery_file:
		for y in x:
			battery_string += y
	battery_file.close()
	return battery_string

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def return_num(temp_value, x_value, string):
	temp = temp_value # assuming percent is double-digit
	num = string[temp:x_value]
	print(num) # output for visual check	
	return int(num)

def battery_helper():
	battery_string = battery_function()
	for x in range(len(battery_string)): # traverse through string until '%' is found
		if battery_string[x] == '%':	
			if battery_string[x-3:x] != '100':
				# temp = x-2 # assuming percent is double-digit
				# num = int(battery_string[temp:x])
				# print(num) # output for visual check	
				return return_num(x-2, x, battery_string)
			else:
				# temp = x-3
				# num = int(battery_string[temp:x])
				# print(num) # output for visual check	
				return return_num(x-3, x, battery_string)
				# return int(battery_string[x-3:x])
				
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def charging_function():	
	os.system('pmset -g ps > charging_status.txt') # macOS command write charging status info to external file	
	charging_file = open('charging_status.txt', 'r') # traverse file for reading ('r' mode)
	charging_string = '' # empty string to append letters from file since contents are un-indexable
	for a in charging_file:
		for b in a:
			charging_string += b
	charging_file.close()	
	print('dude: ' + charging_string[0:32])
	return charging_string

#-------------------------------------------------------------------------------------------------------------

while True:
	time.sleep(5) # wait every five seconds to check battery status
	if charging_function()[0:32] == "Now drawing from 'Battery Power'": # run warnings only when non-charging mode
		print('here')
		if (battery_helper() <= 20): # if battery percentage is or below 20%, notify with sound and put to sleep
			os.system('open "/Users/macuser/Documents/github-repositories/self-made-tools/battery-checker/Check Charging Status.pdf"')
			while True:
				os.system('afplay /System/Library/Sounds/Sosumi.aiff')
				if charging_function()[0:32] != "Now drawing from 'Battery Power'":
					break
				time.sleep(1)
	else:
		if (battery_helper() >= 80): # if battery percentage is or above 80%, notify with sound and put to sleep
			os.system('open "/Users/macuser/Documents/github-repositories/self-made-tools/battery-checker/Check Charging Status.pdf"')
			while True:
				os.system('afplay /System/Library/Sounds/Sosumi.aiff')
				print('LAAAA: ' + charging_function()[0:32] + 'STOP')
				if charging_function()[0:32] == "Now drawing from 'Battery Power'":
					break	
				time.sleep(1)