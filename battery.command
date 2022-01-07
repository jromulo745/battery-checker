#!/usr/bin/env python

import os, time

while True:
	time.sleep(5) # wait every five seconds to check battery status
	os.system('pmset -g batt > battery_info.txt') # macOS command write battery info to external file
	os.system('pmset -g ps > charging_status.txt') # macOS command write charging status info to external file	

	battery_file = open('battery_info.txt', 'r') # traverse file for reading ('r' mode)
	battery_string = '' # empty string to append letters from file since contents are un-indexable
	for x in battery_file:
		for y in x:
			battery_string += y
	battery_file.close()

	charging_file = open('charging_status.txt', 'r') # traverse file for reading ('r' mode)
	charging_string = '' # empty string to append letters from file since contents are un-indexable
	for a in charging_file:
		 for b in a:
			charging_string += b
	charging_file.close()

	# print(battery_string[66:69]) # print only the battery percentage from the battery info file
	# print(battery_string[66:68])

	print(charging_string[0:32])		
		
	for x in range(len(battery_string)): # traverse through string until '%' is found
		if battery_string[x] == '%':
			# print('here!')
			temp = x-2 # assuming percent is duoble-digit
			num = int(battery_string[temp:x])
			# print(num)

	print(num) # output for visual check	
		
	# time.sleep(100)
	# num = int(battery_string[66:68])

	if charging_string[0:32] == "Now drawing from 'Battery Power'": # run warnings only when non-charging mode
		print('here')
		if (num <= 20): # if battery percentage is or below 20%, notify with sound and put to sleep
			while True:
				os.system('afplay /System/Library/Sounds/Sosumi.aiff')
				time.sleep(1)
				# os.system('pmset sleepnow')
		elif (num >= 80): # if battery percentage is or above 80%, notify with sound and put to sleep
			while True:
				os.system('afplay /System/Library/Sounds/Sosumi.aiff')
				time.sleep(1)
				# os.system('pmset sleepnow')

