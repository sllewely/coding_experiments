# pairs of tile coords
@red_tiles = []
MAX_X = 12
MAX_Y = 10

@color_tiles = []

def build_grid
  @color_tiles = Array.new(MAX_X + 1) { Array.new(MAX_Y + 1, ".") }
  puts @color_tiles.inspect
  @red_tiles.each_with_index do |tile, i|
    (x1, y1) = tile
    tile2 = @red_tiles[i+1].nil? ? @red_tiles[0] : @red_tiles[i+1]
    @color_tiles[x1][y1] = "#"
    if x1 != tile2[0]
      # start at the min and color to the max
      start = [x1, tile2[0]].min + 1
      (start...[x1, tile2[0]].max).each do |x|
        @color_tiles[x][y1] = "X"
      end
    else
      start = [y1, tile2[1]].min + 1
      (start...[y1, tile2[1]].max).each do |y|
        @color_tiles[x1][y] = "X"
      end
    end
  end
end

File.foreach('day9input.txt').with_index do |line, i|

  items = line.chomp.split(",").map(&:to_i)
  @red_tiles << items

end

puts @red_tiles.max_by { |tile| tile[0]}.inspect
puts @red_tiles.max_by { |tile| tile[1]}.inspect

puts "---"

build_grid

@color_tiles.transpose.each do |row|
  puts row.join("")
end



