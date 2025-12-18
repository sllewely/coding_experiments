

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

# find all routes svr to dac
# find all routes dac to fft
# find all routes fft to out
# multiply
# then also all the same but svr -> fft -> dac -> out
#

def solve_problem(device_connections)
  routes = device_connections['dac']

  sum = 0
  routes.each do |route|
    sum += traverser(device_connections, route)
  end
  sum

end
# svr to dac 1230541486926
# dac to fft is 0
# fft to dac 5885737
# dac to out 10425
# svr to fft 5842
# the answer is these numbers multiplied together

# how many paths take us to OUT
def traverser(device_connections, device)
  puts device
  return 1 if device == "fft"
  return 0 if device == "dac"
  return 0 if device == "out"
  # return 1 if device == "dac"

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
#the answer is the three paths multiplied together
# svr -> fft -> dac -> out