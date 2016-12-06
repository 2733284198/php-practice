#!/bin/bash

function example1
{
	echo "This is for test.--1111."
}

example1

function example1
{
	echo "This is for test.--3333."
	read -p "Please input the return value:" value
	return $[ $value * 2 ]
}

example2()
{
	echo "This is for test.--2222."
	echo "1"
	echo "2"
	echo "3"
	echo "4"
	ls -l haha
}

example1
echo "The function example1 double value is :$?"

return_value=`example2`
echo "The function example2 return value is :$?"
echo "The function output is:"
echo $return_value

