# dial starts pointing at 50
# spans 0 (left) to 99 (right)
# count how many times it stops on 0

ROT_STRING = /([a-zA-Z])(\d+)/

@pos = 50
@zero_counter = 0

def op(rot)


  # Returns MatchData ie #<MatchData "R37" 1:"R" 2:"37">
  captures = ROT_STRING.match(rot)
  puts captures.captures.inspect
  match = captures[0]
  dir = captures[1]
  steps = captures[2].to_i

  # puts match

  if (dir == "L")
    @pos -= steps
    while (@pos < 0)
      @pos += 100
    end
  end
  if (dir == "R")
    @pos += steps
    while (@pos > 99)
      @pos -= 100
    end
  end

  if @pos == 0
    @zero_counter += 1
  end

  puts @pos

  puts "---"

end

File.foreach('day1input.txt').with_index do |line, i|
  op(line)

end

puts @zero_counter



