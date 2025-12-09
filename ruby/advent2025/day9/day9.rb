# pairs of tile coords
@red_tiles = []

def calc_area(tile1, tile2)
  x_span = [tile1[0], tile2[0]].max - [tile1[0], tile2[0]].min + 1
  y_span = [tile1[1], tile2[1]].max - [tile1[1], tile2[1]].min + 1
  x_span * y_span
end

def find_max
  max = 0
  @red_tiles.each_with_index do |tile, i|
    @red_tiles[i+1..-1].each do |other|
      rect = calc_area(tile, other)
      max = rect if rect > max
    end
  end
  max
end

File.foreach('day9input.txt').with_index do |line, i|

  items = line.chomp.split(",").map(&:to_i)
  @red_tiles << items

end

puts @red_tiles.inspect

puts find_max