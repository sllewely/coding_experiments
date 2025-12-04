@sum = 0

# @ syntax just makes this variable an instance variable -- or in the case of this script, global
@storage = []

def calc_neighbors(r, c)
  # [0, 1, 0, 1, 1, 0, 0]
  #
  [
    c > 0 ? @storage[r][c-1] : 0, # W
    r > 0 && c > 0 ? @storage[r-1][c-1] : 0, # NW
    r > 0 ? @storage[r-1][c] : 0, # N
    r > 0 && c < @storage[0].length - 1 ? @storage[r-1][c+1] : 0, # NE
    r < @storage.length - 1 ? @storage[r+1][c] : 0, # S
    r < @storage.length - 1 && c > 0 ? @storage[r+1][c-1] : 0, # SW
    c < @storage[0].length - 1 ? @storage[r][c+1] : 0, # E
    r < @storage.length - 1 && c < @storage[0].length - 1 ? @storage[r+1][c+1] : 0 # SE
  ]
end

def count_accessible()
  sum_this_pass = 0
  (0...@storage.length).each do |r|
    (0...@storage[0].length).each do |c|
      next unless @storage[r][c] == 1
      count = calc_neighbors(r, c)
      if count.sum < 4
        @storage[r][c] = 0
        sum_this_pass += 1
        @sum += 1
      end
    end
  end
  sum_this_pass
end

File.foreach('day4input.txt').with_index do |line, i|
  @storage << line.chomp.chars.map { |e| e == '@' ? 1 : 0}
end

puts calc_neighbors(0, 2)

count_accessible()
puts @sum
