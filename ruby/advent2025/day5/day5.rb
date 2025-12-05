RANGE_STRING = /(\d+)-(\d+)/

@fresh_ranges = []
@fresh_count = 0

def build_ranges(range)
  captures = RANGE_STRING.match(range)
  lower = captures[1].to_i
  upper = captures[2].to_i
  @fresh_ranges << Range.new(lower, upper)

end


def try_ingredient(ingredient)
  ingredient_id = ingredient.to_i
  if @fresh_ranges.any? { |range| range.include?(ingredient_id) }
    @fresh_count += 1
  end
end

building_ranges = true

File.foreach('day5input.txt').with_index do |line, i|
  if building_ranges
    if line.chomp == ""
      building_ranges = false
      next
    end
    build_ranges(line.chomp)
  else
    # try ingredients
    try_ingredient(line.chomp)
  end
end

puts @fresh_count