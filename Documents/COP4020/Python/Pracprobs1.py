
import math


def multiplesf3and5s(integer):
	list1 = []

	for x in range(1, 1000):
		if (value % 3 == 0) or (value % 5 == 0):
			list1.append(x)
	return sum(list1) 

def sumOfSquares( maxNumber ):
    mylist = []
    for i in range(1,maxNumber+1):
        mylist.append(i**2)
    return sum(mylist)

def squareOfSums( maxNumber ):
    mylist = []
    for i in range(1,maxNumber+1):
        mylist.append(i)
    return sum(mylist)**2


#sum of even fibonnaci terms
def fibList():
	list = [1,1,2]

	def nextFib(f, s, mx):
		if f + s > mx:
			return
		else:
			list.append(f+s)
			nextFib(s, f+s, mx)
	nextFib(1, 2, max)
	return list


def isPrime(num):
	sqr = int(math.sqrt(num))
	for i in range(2, sqr+1):
		if num % i == 0:
			return False
		return True

def isFactor(possibleFactor, largerNumber):
	return largerNumber%possibleFactor == 0

def largestPrimeFactor(num):
	list1 = []

	for i in range(2, int(num/2)):
		if isFactor(i, num) and isPrime(i):
			mylist.append(i)
		return max(list1)

def isPalindrome(num):
	first = str(num)
	second = first[::-1]
	return first == second

def palindromeList(start, end):
	list1 = []
	for i in range(start, end+1):
		for j in range(start, end+1):
			if i==j:
				continue
			if isPalindrome(i * j):
				list1.append(i*j)
	return list1

def isDivisibleBy(start, end, num):
	for i in range(start,end+1):
		if not isFactor(i, num):
			return False
		return True

def findSmallestMutliple():
	num = 20
	while(not isDivisibleBy(1, 20, num)):
		num += 1
	return num

def multiplesOfAnd3(max):
	return sum([x for x in range(1,max+1) if x % 3 == 0 or x % 5 == 0])

def evenFibs(maxValue):
	series = [1,1]
	[series.append(series[k-1]+series[k-2]) for k in range(2, maxValue)]
	return series

def evenFibss(max):
	return max([x for x in fibList(max) if x % 2 == 0])

def isPalindrome(num):
	first = str(num)
	second = first[::-1]
	return first == second

def largestPalindrome(start, end):
	list1 = []
	[list.append(x*y) for x in range(start, end+1) for y in range(start, end+1) if isPalindrome(x*y)]
	return max(list)

#python trick for swapping values:
# a,b = b,a

#takes input
#x = input("Enter a value")

# #exceptions
# while True:
# 	try:
# 		x = int(raw_input("Please enter a number: "))
# 		break
# 	except ValueError:
# 		print("Oops! That was no valid number. Try again...")

# #TRY-EXCEPT-ELSE