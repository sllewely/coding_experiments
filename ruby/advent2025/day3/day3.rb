


def find_max(line)
  first_digit = 0
  first_digit_index = -1
  line.chars.each_with_index do |e, i|
    next if i >= (line.length - 1)

    if e.to_i > first_digit
      first_digit = e.to_i
      first_digit_index = i
    end
  end

  second_digit = line.chars[first_digit_index + 1].to_i
  second_digit_index = first_digit_index + 1
  (first_digit_index + 1...line.length).each do |i|
    if line.chars[i].to_i > second_digit
      second_digit = line.chars[i].to_i
      second_digit_index = i
    end
  end

  puts "#{first_digit} #{first_digit_index}"
  puts "#{second_digit} #{second_digit_index}"
  first_digit * 10 + second_digit
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