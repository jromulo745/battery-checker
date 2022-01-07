#!/usr/bin/env python

import os, time

while True:
	time.sleep(5) # wait every five seconds to check battery status
	os.system('pmset -g batt > battery_info.txt') # macOS command write battery info to external file

	file = open('battery_info.txt', 'r') # traverse file for reading ('r' mode)
	string = '' # empty string to append letters from file since contents are un-indexable
	for x in file:
		for y in x:
			string += y

	# print(string[66:69]) # print only the battery percentage from the battery info file
	# print(string[66:68])

	for x in range(len(string)): # traverse through string until '%' is found
		if string[x] == '%':
			# print('here!')
			temp = x-2 # assuming percent is duoble-digit
			num = int(string[temp:x])
			# print(num)

	print(num) # output for visual check	
		
	# time.sleep(100)
	# num = int(string[66:68])

	if (num <= 20): # if battery percentage is or below 20%, notify with sound and put to sleep
		os.system('pmset sleepnow')
		while True:
			time.sleep(1)
			os.system('afplay /System/Library/Sounds/Sosumi.aiff')
	elif (num >= 80): # if battery percentage is or above 80%, notify with sound and put to sleep
		os.system('pmset sleepnow')
		while True:
			time.sleep(1)
			os.system('afplay /System/Library/Sounds/Sosumi.aiff')
	file.close()
