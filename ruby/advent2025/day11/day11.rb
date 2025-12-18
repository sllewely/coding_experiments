

# regex is greedy by default.  ? is minimum match?
DEVICE_REGEX = /(\w+): (.+)/
@device_routes = Hash.new

def process_line(line)
  matches = DEVICE_REGEX.match(line)
  device = matches[1]
  connections = matches[2].split(' ')
  puts "---"
  puts device
  puts connections.inspect
  [device, connections]
end

def solve_problem(device_connections)
  routes = device_connections['you']

  sum = 0
  routes.each do |route|
    sum += traverser(device_connections, route)
  end
  sum

end

# how many paths take us to OUT
def traverser(device_connections, device)
  return 1 if device == "out"

  # if we have visited this device before, use the amortized val
  sum = 0
  device_connections[device].each do |next_device|
    sum += if @device_routes.has_key?(next_device)
       @device_routes[next_device]
    else
      traverser(device_connections, next_device)
    end
  end
  @device_routes[device] = sum
  sum
end

# adjacency list
device_connections = {}
File.foreach('day11input.txt').with_index do |line, i|

  device_connection = process_line(line.chomp)
  device_connections[device_connection[0]] = device_connection[1]
end

puts solve_problem(device_connections)