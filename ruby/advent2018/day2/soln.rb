class Solver

  def initialize
    @two_count = 0
    @three_count = 0

    File.foreach('input.txt').with_index do |line, i|
      letter_counts = process_line(line)
      @two_count += 1 if letter_counts.values.any? {|count| count == 2}
      @three_count += 1 if letter_counts.values.any? {|count| count == 3}
    end
  end

  def process_line(line)
    line.chars.each_with_object(Hash.new(0)) do |char, h|
      h[char] += 1
    end
  end

  def solve
    @three_count * @two_count
  end
end


solver = Solver.new
puts solver.solve