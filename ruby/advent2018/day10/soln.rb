class Solver

  def initialize
    @points = []
    @translations = []

    File.foreach('input.txt').with_index do |line, i|
      x = line[10, 6].to_i
      y = line[18, 6].to_i
      # puts "#{x}, #{y}"
      @points << [x, y]
      xt = line[36, 2].to_i
      yt = line[40, 2].to_i
      @translations << [xt, yt]
      # puts "#{xt}, #{yt}"
    end
  end

  def points_at_time(t)
    # grid = Array.new(200) { Array.new(200) { false } }
    new_points = []
    h = {}
    min_x = 1000000
    min_y = 1000000
    max_x = 0
    max_y = 0
    @points.each_with_index do |(x, y), i|
      xp = (x + (@translations[i][0] * t))
      yp = (y + (@translations[i][1] * t))
      new_points << [xp, yp]
      # get row
      if h[yp]
        h[yp][xp] = true
      else
        h[yp] = { xp => true }
      end
      min_x = xp if xp < min_x
      min_y = yp if yp < min_y
      max_x = xp if xp > max_x
      max_y = yp if yp > max_y
    end

    # puts h.inspect

    (min_y..max_y).each do |y|
      row = h[y]
      if row.nil?
        puts "*"
        next
      end
      str = "*"
      (min_x..max_x).each do |x|
        if row[x]
          str += "#"
        else
          str += "_"
        end

      end
      puts str

    end

    puts

    puts "#{max_x - min_x}  #{max_y - min_y}"

    # grid = Array.new(max_x - min_x + 1) { Array.new(max_y - min_y + 1) { false } }
    # new_points.each do |(x, y)|
    #   grid[x -min_x][y - min_y] = true
    # end
    #
    # print_grid(grid.transpose)
  end

  def print_h(h) end

  def print_grid(grid)
    grid.each do |row|
      str = ""
      row.each do |cell|
        if cell
          str += "#"
        else
          str += "_"
        end
      end
      puts str
    end
  end

end

solver = Solver.new
solver.points_at_time(10011)