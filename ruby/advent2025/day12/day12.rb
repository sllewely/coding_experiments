# awh this one was a little trivial

DIMENSIONS_REGEX = /(\d\d)x(\d\d): (\d\d) (\d\d) (\d\d) (\d\d) (\d\d) (\d\d)/

def process_line(line)
  matches = DIMENSIONS_REGEX.match(line)
  x = matches[1].to_i
  y = matches[2].to_i
  count0 = matches[3].to_i
  count1 = matches[4].to_i
  count2 = matches[5].to_i
  count3 = matches[6].to_i
  count4 = matches[7].to_i
  count5 = matches[8].to_i
  dimension = x * y
  bad_packing = 9 * (count0 + count1 + count2 + count3 + count4 + count5)
  puts "#{dimension} > #{bad_packing}"
  bad_packing <= dimension ? 1 : 0
end

sum = 0
File.foreach('day12input.txt').with_index do |line, i|

  sum += process_line(line.chomp)
end
puts sum