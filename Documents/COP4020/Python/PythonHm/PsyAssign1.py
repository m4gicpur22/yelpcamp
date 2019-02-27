#Affner Lefevre
#COP 4020
#2/24/2019

import sys
import re
import importlib

#make a list of words that have more than three letters
#begin with a vowel or contain any letters from 2nd string
#compares first string with chars in 2nd string
def word_smith(string1, string2):

	removeSymbs = re.sub(r'[?|$|.|!]',r'',string1)
	words = removeSymbs.split()
	valid_string = [];

	for word in words:
		if len(word) > 3:
			valid_string.append(word)

	removeSymbs2 = re.sub(r'[?|$|.|!]',r'',string2)
	removeNumbers2 = re.sub(r'[^a-zA-Z ]',r'', removeSymbs2)
	words2 = removeNumbers2.split()
	
	valid_string2 = []

	for word in words2:
		valid_string2.append(word)
	 	
	list1 = []

	for word in valid_string:   
	 	if (word[0] in ('aeiouy' or 'AEIOUY')) or strcmp(word,valid_string2):
	 		list1.append(word)
	
	return (len(list1))
	

def strcmp(str1, str2):
	
	for char in str1:
		if char in str2:
			return True
		else:
			return False


#recursive function for converting from decimal to base 4 
def quaternary(integer):
	if integer == 0:
		return 0
	else:
		return (integer%4 + 10*quaternary(integer//4))

def base_builder(integer):
	quaternary_value = quaternary(integer)
	summ = 0

	while(quaternary_value > 0):
		summ += quaternary_value % 10

		quaternary_value //= 10

	return (summ, quaternary(integer))

# print(word_smith("Programming languages is definitely the best \
#             course I have taken in my entire undergraduate CS career!", "Don't \
#             OVERTHINK it!"))

# print(base_builder(493))

