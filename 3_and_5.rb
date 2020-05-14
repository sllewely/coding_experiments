require 'set'
fives = Array.new(201) { |n| n * 5 }
puts fives
threes = Array.new(334) { |n| n * 3 }
puts threes
set = Set.new(fives).merge(threes)
puts set
puts set.sum

