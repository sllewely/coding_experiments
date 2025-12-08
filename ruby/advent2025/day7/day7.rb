
@items = []
@count = 0

def splits
  width = @items[0].length
  height = @items.length

  #find the start
  s = @items[0].index('S')
  puts s
  tachyons = [s]

  @items[1..height].each do |row|
    puts tachyons.inspect
    puts row.inspect
    new_tachyons = []
    tachyons.each do |t|
      if row[t] == '^'
        @count += 1
        new_tachyons << t - 1
        new_tachyons << t + 1
      else
        new_tachyons << t
      end
    end

    tachyons = new_tachyons.uniq

  end

end




File.foreach('day7input.txt').with_index do |line, i|

  items = line.chomp.chars
  @items << items

end

splits

puts @count