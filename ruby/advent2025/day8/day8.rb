class Problem
@items = []

# every junction box starts on its own circuit
@circuits = []
@connections = []

@distances = []
@distance_map = {}

# calculate the 3d straight line dist between two points
def straight_line_distance(jb1, jb2)
  Math.sqrt((jb1[0].to_i - jb2[0].to_i)**2 + (jb1[1].to_i - jb2[1].to_i)**2 + (jb1[2].to_i - jb2[2].to_i)**2)
end

# create a map of all distances
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
    next if @connections.has_key?(key)
    if dist < min
      min = dist
      pair = key
    end
  end

  (i, j) = pair
  # puts "merging #{@items[i].inspect} - #{@circuits[i]} and #{@items[j]} - #{@circuits[j]}"

  return if pair.empty?
  # now we've found our nearest, add them to circuits
  to_merge = all_in_circuit(@circuits[j])
  to_merge.each do |m|
    @circuits[m] = @circuits[i]
  end
  @connections[pair] = true
end

def all_in_circuit(circuit)
  indices = []
  @circuits.each_with_index do |c, i|
    indices << i if c == circuit
  end
  indices
end

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

  puts distance_map.inspect

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


def initialize
  @items = []
  @circuits = []
  @distance_map = {}
  @connections = {}

  File.foreach('day8input.txt').with_index do |line, i|

    items = line.chomp.split(',')
    @items << items

  end

end

end

p = Problem.new
p.entire_problem
