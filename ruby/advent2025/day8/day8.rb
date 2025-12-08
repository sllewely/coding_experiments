
@items = []

# every junction box starts on its own circuit
@circuits = []

@distances = []
@distance_map = {}

def straight_line_distance(jb1, jb2)
  Math.sqrt((jb1[0].to_i - jb2[0].to_i)**2 + (jb1[1].to_i - jb2[1].to_i)**2 + (jb1[2].to_i - jb2[2].to_i)**2)
end

def all_distances
  @distances = (0...@items.length).map { Array.new(@items.length, 0) }

  @items.each_with_index do |jb1, i|
    @items.each_with_index do |jb2, j|
      @distances[i][j] = straight_line_distance(jb1, jb2)
    end
  end
end

def all_distances_map(jbs)
  distance_map = {}
  jbs.each_with_index do |jb1, i|
    jbs.each_with_index do |jb2, j|
      if i < j
        distance_map[[i, j]] = straight_line_distance(jb1, jb2)
      end
    end
  end
  distance_map
end



def create_circuit(distance_map)
  # first get the minimum distance
  # where they are not already in the same circuit
  min = Float::INFINITY
  pair = []
  distance_map.each do |(key, dist)|
    next if @circuits[key[0]] == @circuits[key[1]]
    if dist < min
      min = dist
      pair = key
    end
  end

  (i, j) = pair
  puts "merging #{@items[i].inspect} - #{@circuits[i]} and #{@items[j]} - #{@circuits[j]}"

  # now we've found our nearest, add them to circuits
  to_merge = all_in_circuit(@circuits[j])
  to_merge.each do |m|
    @circuits[m] = @circuits[i]
  end
end

def all_in_circuit(circuit)
  indices = []
  @circuits.each_with_index do |c, i|
    indices << i if c == circuit
  end
  indices
end

def create_circuits
  @circuits = (0...@items.length).to_a
  1000.times { create_circuit }
end

@circuit_counts = {}

def count_matches(circuits)
  circuit_counts = {}
  circuits.each do |circuit|
    next if circuit_counts.has_key?(circuit)
    circuit_counts[circuit] = all_in_circuit(circuit).length
  end
  circuit_counts
end


def entire_problem
  # generate all distances
  distance_map = all_distances_map(@items)

  @circuits = (0...@items.length).to_a

  # create circuits based on minimum distances
  10.times { create_circuit(distance_map) }

  puts "---"

  puts @circuits.inspect

  count_h = count_matches(@circuits)

  puts count_h.inspect

  top_3 = count_h.values.sort.reverse.take(3)
  puts top_3.inspect
  mult = top_3.inject(1) { |acc, e| acc *= e }
  puts mult

end


File.foreach('day8input.txt').with_index do |line, i|

  items = line.chomp.split(',')
  @items << items

end

entire_problem


