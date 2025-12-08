

@items = []
@total = 0

# scan horizontally
def scan()
  current_op = nil
  new_op = true
  current_total = 0
  @items.transpose.each do |col|
    if col.all? { |e| e == " " }
      new_op = true
      @total += current_total
      next
    end
    if new_op
      current_op = col[-1]
      current_total = current_op == "+" ? 0 : 1
      new_op = false
    end
    number = get_number(col[0...-1])
    if current_op == "+"
      current_total += number
    else
      current_total *= number
    end
  end

  @total += current_total
end

def get_number(col)
  col.filter { |e| e != " " }.join.to_i
end



File.foreach('day6input.txt').with_index do |line, i|

  items = line.chomp.chars
  @items << items

end


sum = scan()

puts sum

