require 'set'

RANGE_STRING = /(\d+)-(\d+)/


@invalids = Set.new
@ranges = []
@max = -1

def invalid(num)
  num + (num * (10 ** num.digits.length))
end

def invalid3(num)
  num + (num * (10 ** num.digits.length)) + (num * (10 ** (2 *num.digits.length)))
end

def invalid5(num)
  num + (num * (10 ** num.digits.length)) + (num * (10 ** (2 *num.digits.length)))+ (num * (10 ** (3 *num.digits.length))) + (num * (10 ** (4 *num.digits.length)))
end

def invalid7(num)
  num + (num * (10 ** num.digits.length)) + (num * (10 ** (2 *num.digits.length)))+ (num * (10 ** (3 *num.digits.length))) + (num * (10 ** (4 *num.digits.length))) + (num * (10 ** (5 *num.digits.length))) + (num * (10 ** (6 *num.digits.length)))
end

## should I just generate all invalids?
# and check if each one is in a range?

def build_ranges(range)
  captures = RANGE_STRING.match(range)
  lower = captures[1].to_i
  upper = captures[2].to_i
  @ranges << Range.new(lower, upper)
  @max = upper if upper > @max

  # ldigits = lower.digits.length
  # start_len = ldigits / 2
  # start_len += 1 if ldigits.odd?
  #
  # # while (true) do
  # #   try_invalid = invalid(lower)
  # #   @invalids << try_invalid if try_invalid <= upper
  # # end

end

def build_invalids
  (1..9).each do |i|
    # single digit
    @invalids.add invalid(i)
    @invalids.add invalid3(i)
    @invalids.add invalid5(i)
    @invalids.add invalid7(i)
    (0..9).each do |j|
      seq = (i * 10) + j
      @invalids.add invalid((i * 10) + j)
      @invalids.add invalid3(seq)
      @invalids.add invalid5(seq)
      (0..9).each do |k|
        seq = (i * (10 ** 2)) + (j * 10) + k
        @invalids.add invalid((i * (10 ** 2)) + (j * 10) + k)
        @invalids.add invalid3(seq)
        (0..9).each do |l|
          @invalids.add invalid((i * (10 ** 3)) + (j * (10 ** 2)) + (k * 10) + l)
          (0..9).each do |m|
            @invalids.add invalid((i * (10 ** 4)) + (j * (10 ** 3)) + (k * (10 ** 2)) + (l * 10) + m)
          end
        end
      end

    end

  end
end

# this problem has one single line
content = File.readlines('d2.txt')[0]

content.split(',').each do |range|
  build_ranges(range)
end

build_invalids

@invalid_sum = 0

@chosen_invalids = []

sum = @invalids.filter { |invalid| @ranges.any? { |range| range.include?(invalid) } }.inject(:+)

other_sum = 0

# @invalids.sort.each do |invalid|
#   if @ranges.any? { |range| range.include?(invalid) }
#     @chosen_invalids << invalid
#     other_sum += invalid
#   end
# end

# sum = @chosen_invalids.sum

# puts @max
# puts @ranges
# puts @invalids.size
# puts @chosen_invalids
# puts "---"
puts sum
puts invalid7(2)
# puts other_sum
