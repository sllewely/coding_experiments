
@items = []
@count = 0

@amor = {}

def traverse
  s = @items[0].index('S')
  sum = bottom_up_traverse(1, s)

end

def bottom_up_traverse(r, i)
  return 1 if r >= @items.length

  sum = 0

  if @amor.has_key?([r, i])
    return @amor[[r, i]]
  end

  if @items[r][i] == '^'
    sum += bottom_up_traverse(r + 1, i - 1)
    sum += bottom_up_traverse(r + 1, i + 1)
  else
    sum += bottom_up_traverse(r + 1, i)
  end

  @amor[[r, i]] = sum

  sum

end




File.foreach('day7input.txt').with_index do |line, i|

  items = line.chomp.chars
  @items << items

end

sum = traverse

puts sum