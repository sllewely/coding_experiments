RANGE_STRING = /(\d+)-(\d+)/

@fresh_ranges = []

def build_ranges(range)
  captures = RANGE_STRING.match(range)
  lower = captures[1].to_i
  upper = captures[2].to_i
  ranges_to_keep = []

  # dont add if fully in a range
  return if @fresh_ranges.any? { |range| range.begin < lower && range.end > upper }

  # check for overlaps
  @fresh_ranges.each do |old_range|
    # check if an existing range overlaps with our range
    if (lower..upper).include? old_range.begin
      upper = old_range.end if old_range.end > upper
      next
    end
    if (lower..upper).include? old_range.end
      lower = old_range.begin if old_range.begin < lower
      next
    end
    ranges_to_keep << old_range
  end

  @fresh_ranges = ranges_to_keep
  @fresh_ranges << Range.new(lower, upper)

end



building_ranges = true

File.foreach('day5input.txt').with_index do |line, i|
  if building_ranges
    if line.chomp == ""
      building_ranges = false
      next
    end
    build_ranges(line.chomp)
  end
end

sum =@fresh_ranges.inject(0) { |sum, range| sum += range.size }

puts sum