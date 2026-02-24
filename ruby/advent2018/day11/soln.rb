class Solver

  def initialize(serial_number)
    @serial_number = serial_number
    @grid = Array.new(300) do |x|
      Array.new(300) do |y|
        rack_id = (x + 1) + 10
        power_level = (y + 1) * rack_id
        power_level += serial_number
        power_level = power_level * rack_id
        hundreds_digit = (power_level.to_s.chars.reverse[2] || 0).to_i # hundreds digit
        # puts "#{power_level}: #{hundreds_digit}"
        hundreds_digit - 5
      end

    end
  end

  def print_grid
    puts @grid.inspect

  end

  # this is for the 3 x 3 part a
  def find_max
    max = 0
    max_x = 0
    max_y = 0
    (0..297).each do |x|
      (0..297).each do |y|
        square = sum_square(x, y)
        if square > max
          max = square
          max_x = x
          max_y = y
          puts ""
        end
      end
    end
    puts "#{max}: #{max_x + 1}, #{max_y + 1}"
    max
  end

  # this is for part b
  def find_max_of(size)
    puts "finding max of #{size}"
    max = -9999999999
    max_x = 0
    max_y = 0
    sums = []
    (0..(300 - size)).each do |x|
      sums[x] = []
      (0..(300 - size)).each do |y|
        square = sum_square_of(x, y, size)
        sums[x] << square
        if square > max
          max = square
          max_x = x
          max_y = y
          # puts ""
        end
      end
    end
    puts "#{size}: #{max}: #{max_x + 1}, #{max_y + 1}"
    max
  end

  # this is for part b
  def sum_square_of(x, y, size)
    sum = 0
    (x...(x + size)).each do |xi|
      (y...(y + size)).each do |yi|
        sum += @grid[xi][yi]
      end
    end
    # puts "#{x} #{y} sum: #{sum}"
    sum
  end

  def print_square(x, y)
    puts "#{@grid[x][y]}"
  end

  # this is for the 3 x 3 part a
  def sum_square(x, y)

    @grid[x][y] +
      @grid[x + 1][y] +
      @grid[x + 2][y] +
      @grid[x][y + 1] +
      @grid[x + 1][y + 1] +
      @grid[x + 2][y + 1] +
      @grid[x][y + 2] +
      @grid[x + 1][y + 2] +
      @grid[x + 2][y + 2]
  rescue
    puts "#{x} #{y}"
  end

end

solver = Solver.new(5791)
maxes = (0..99).map do |size|
  solver.find_max_of(size)
end
#
# solver.find_max_of(300)
puts maxes.max
