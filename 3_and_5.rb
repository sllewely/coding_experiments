require 'set'
fives = Array.new((1000/5) + 1) { |n| n * 5 }
threes = Array.new((1000/3) + 1) { |n| n * 3 }
set = Set.new(fives).merge(threes)
puts set.sum

