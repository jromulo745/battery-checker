#!/usr/bin/env python

import os, time

while True:
	time.sleep(5)
	os.system('pmset -g batt > battery_info.txt')

	file = open('battery_info.txt', 'r')
	string = ''
	for x in file:
		for y in x:
			string += y

	print(string[66:69])
	num = int(string[66:68])
	if (num <= 20):
		print('Time to charge')
		os.system('pmset sleepnow')
		break
	elif (num >= 50):
		print('Stop charging')
		while True:
			time.sleep(1)
			os.system('afplay /System/Library/Sounds/Sosumi.aiff')
		os.system('pmset sleepnow')
	file.close()
