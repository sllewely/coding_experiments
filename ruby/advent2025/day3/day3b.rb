

# this is a dp problem now
# choose or not choose the current number
# take the max of the choices

# key is pos
# val is max so far
@mem = {}

def find_max(line)
  # reset for a new line
  @mem = {}
  max_choices(line, 0, 0)
end

def max_choices(line, pos, digits)
  return "" if digits == 12
  return "" if pos >= line.length


  # I need to build from the end, not the beginning
  if @mem.key?([pos, digits])
    return @mem[[pos, digits]]
  end

  with = line[pos] + max_choices(line, pos + 1, digits + 1)
  without = max_choices(line, pos + 1, digits)
  if (with.to_i > without.to_i)
    @mem[[pos, digits]] = with
    return with
  else
    @mem[[pos, digits]] = without
    return without
  end

end




sum = 0
File.foreach('day3input.txt').with_index do |line, i|
  puts line
  max = find_max(line.chomp)
  sum += max.to_i
  puts max
  puts "---"
end

puts sum