#Bubble sort
def bubble_sort(array)
	swaps = true
	while swaps == true
		swaps = false
		(array.length - 1).times do |x|
			if array[x] > array[x+1]
				array[x], array[x+1] = array[x+1], array[x]
				swaps = true
			end
		end
	end
	array
end

#Accepts a block that determines a custom order. Block
# must return -1 if the first variable if "smaller" than
# the second.
def bubble_sort_by(array)
	swaps = true
	while swaps == true
		swaps = false
		(array.length - 1).times do |x|
			if (yield array[x], array[x+1]) < 0
				array[x], array[x+1] = array[x+1], array[x]
				swaps = true
			end
		end
	end
	array
end

puts "#{bubble_sort([0,5,4,3,9,8,6,2])}"
puts "#{bubble_sort_by(["hi","hello","hey"]) {|left,right|
	left.length - right.length
}}"
