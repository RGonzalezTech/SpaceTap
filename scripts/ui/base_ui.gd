class_name BaseUI
extends Control

## This is a base class for all future UI elements. 
## It contains some common functionality that will be applicable in many UI elements.

## This function accepts a number and returns a string with commas separating every three digits.
## For example, 1234567 would be formatted as "1,234,567".
func format_number_with_commas(number: int) -> String:
	var num_str := str(number) # Convert the number to string
	var formatted_str := "" # Initialize the resulting string
	var count := 0 # A counter to track every third digit

	# Iterate over the number string in reverse
	for i in range(num_str.length() - 1, -1, -1):
		# Prepend the current digit to the formatted string
		formatted_str = num_str[i] + formatted_str
		count += 1

		# If count is 3 and not the last set, add a comma
		if count == 3 and i != 0:
			formatted_str = "," + formatted_str
			count = 0 # Reset the counter after adding a comma

	return formatted_str
