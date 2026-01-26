# fix squiggles and turn off ai
# careful reasoning through edge cases
# work through real cases
# know your IDE
# use "constant" instead of unit
class MedianSearch


  def initialize
    @break = 0
  end

# two sorted arrays as input
def median_search(array1, array2)
  bin_search(array1, array2, 0, array1.length - 1, 0, array2.length - 1)
end


def bin_search(array1, array2, lowera, uppera, lowerb, upperb)
  # we're at size 1
  if lowera == uppera
    # confirm floats
    return (array1[lowera].to_f + array2[lowerb].to_f) / 2
  end
  pointer1 = lowera + (uppera - lowera) / 2
  pointer2 = upperb - (pointer1 - lowera)
  @break += 1
  puts "#{pointer1} from #{lowera} #{uppera} :#{array1[pointer1]}"
  puts "#{pointer2} from #{lowerb} #{upperb} :#{array2[pointer2]}"
  puts "---"
  return if @break >= 10
  return array1[pointer1] if array1[pointer1] == array2[pointer2]

  # split the ranges
  if array1[pointer1] < array2[pointer2]
    # consider the upper half of array1's split
    bin_search(array1, array2, pointer1 + 1, uppera, lowerb, pointer2)
  else
    bin_search(array1, array2, lowera, pointer1, pointer2 + 1, upperb)
  end
end

end



array1 = [1, 2, 3, 4]
array2 = [1, 2, 3, 4]

ms = MedianSearch.new

puts ms.median_search(array1, array2)