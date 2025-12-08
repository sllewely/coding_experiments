

@items = []


def operate()

  @items.transpose.inject(0) do |acc, row|
    acc += op(row)
  end

end

def op(row)
  if row[-1] == "+"
    row[0...-1].inject(0) { |acc, e| acc += e.to_i }
  elsif row[-1] == "*"
    row[0...-1].inject(1) { |acc, e| acc *= e.to_i}
  else
    puts "unexpected #{row[-1]}"
  end
end




File.foreach('day6input.txt').with_index do |line, i|

  items = line.chomp.split(/\s+/)
  if items[0] == ""
    items = items[1..-1]
  end

  @items << items

end

@items.transpose.inspect

sum = operate()

puts sum

