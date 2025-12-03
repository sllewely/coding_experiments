

# this is a dp problem now
# choose or not choose the current number
# take the max of the choices

# key is pos
# val is max so far
@mem = {}

def find_max(line)
  max_choices(line, 0, 0)
end

def max_choices(line, pos, choice_so_far)
  return choice_so_far if choice_so_far.digits.length == 12
  return choice_so_far if pos >= line.length

  to_choose = max_choices(line, pos + 1, choice_so_far * 10 + line[pos].to_i)
  not_choose = max_choices(line, pos + 1, choice_so_far)
  [to_choose, not_choose].max
end


sum = 0
File.foreach('day3input.txt').with_index do |line, i|
  puts line
  max = find_max(line.chomp)
  sum += max
  puts max
  puts "---"
end

puts sum