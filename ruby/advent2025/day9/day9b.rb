# pairs of tile coords
@red_tiles = []

def calc_area(tile1, tile2)
  x_span = [tile1[0], tile2[0]].max - [tile1[0], tile2[0]].min + 1
  y_span = [tile1[1], tile2[1]].max - [tile1[1], tile2[1]].min + 1
  x_span * y_span
end

def solve_problem(red_tiles)
  # calc maxes
  # sort them desc
  # reject if the rect interior overlaps with the interior of a line

  # [tile1, tile2, area]
  rect_areas = []

  # missing edge case is 0, n-1
  red_tiles.each_with_index do |tile, i|
    red_tiles[i+1..-1].each do |other|
      rect_areas << [tile, other, calc_area(tile, other)]
    end
  end

  # tile1, tile2, area
  sorted_red_tiles = rect_areas.sort_by { |e|  -e[2] }

  # since they're all sorted, return the first that passes
  sorted_red_tiles.each do |(tile1, tile2, area)|
    # puts "#{tile1.inspect} #{tile2.inspect} #{area}"

    next if all_has_overlap?(tile1, tile2, red_tiles)

    return area
  end

end

# compare our rectangle against all tiles
def all_has_overlap?(tile1, tile2, all_tiles)
  min_x = [tile1[0], tile2[0]].min
  max_x = [tile1[0], tile2[0]].max
  min_y = [tile1[1], tile2[1]].min
  max_y = [tile1[1], tile2[1]].max

  # our rect is too small to overlap
  return false if max_x - min_x <= 1
  return false if max_y - min_y <= 1

  # we only care about the inner spaces, not the border
  x_range = (min_x + 1...max_x)
  y_range = (min_y + 1...max_y)

  # puts "---" if tile1 == [9,5] && tile2 == [2,3]
  # puts "#{x_range.to_a.inspect}, #{y_range.to_a.inspect}" if tile1 == [9,5] && tile2 == [2,3]

  all_tiles.each_with_index do |other, i|
    other_tile2 = i + 1 == all_tiles.length ? all_tiles[0] : all_tiles[i+1]

    return true if has_overlap?(x_range, y_range, other, other_tile2)
  end

  false
end

def has_overlap?(range_x, range_y, other, other_tile2)
  other_min_x = [other[0], other_tile2[0]].min
  other_max_x = [other[0], other_tile2[0]].max
  other_min_y = [other[1], other_tile2[1]].min
  other_max_y = [other[1], other_tile2[1]].max

  # we're traversing y but should confirm x in range
  if other_min_x == other_max_x
    return false unless range_x.include?(other_min_x)

    return (other_min_y + 1 ... other_max_y).any? do |y|
      range_y.include?(y)
    end
  end

  # we're traversing x but should confirm y in range
  return false unless range_y.include?(other_min_y)

  return (other_min_x + 1 ... other_max_x).any? do |x|
    range_x.include?(x)
  end
end


File.foreach('day9input.txt').with_index do |line, i|

  items = line.chomp.split(",").map(&:to_i)
  @red_tiles << items

end


puts solve_problem(@red_tiles)