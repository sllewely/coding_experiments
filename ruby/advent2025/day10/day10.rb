@lights_target = []

LIGHTS_REGEX = /\[([\.\#])\]/
# ? is non-greedy regex
BUTTON_REGEX = /\((.+?)\)/

JOLTAGE_REGEX = /\{(.+?)\}/

def process_line(line)
  matches = /\[(.+)\] (.+) \{(.+)\}/.match(line)
  # puts "#{matches[1]} - #{matches[2]} - #{matches[3]}"
  lights = matches[1].chars.map { |e| e == "#" ? 1 : 0 }
  buttons = matches[2].split(' ').map { |button| button.split(',').map(&:to_i)}
  joltages = matches[3].split(',').map(&:to_i)
  puts "---"
  puts lights.inspect
  puts buttons.inspect
  puts joltages.inspect

  puts bfs_with_pruning(lights, buttons)

end

def bfs_with_pruning(target_config, buttons)
  num_lights = target_config.length
  target = Array.new(num_lights, 1)
  # the branches are all of the buttons
  # we dont need to operate on previously seen states
  previously_found_perms = Set.new()

  current_press = Set.new << Array.new(num_lights, 0)

  presses = 1
  while true
    # find everything that results from pressing all buttons
    # on all possible states from the prev round
    results = explode(current_press, buttons)
    current_press = results - previously_found_perms
    return presses if current_press.any? { |e| e == target}
    previously_found_perms << results
    presses += 1

  end
end

def explode(configs, buttons)
  new_configs = Set.new
  # a config is a state of on/off lights in an array
  configs.each do |config|
    buttons.each do |button|
      # a button toggles mutliple lights on a config
      output = config.clone
      button.each do |light|
        output[light] = output[light] == 0 ? 1 : 0
      end
      new_configs << output
    end
  end
  new_configs
end

# we're going to do bfs
# keep a queue of states to process
# and a queue of the next iteration (the result of processing)
# we can skip any that have appeared in a previous queue

def apply_buttons(config, buttons)
  new_configs = Set.new
  buttons.each do |button|
    # a button toggles mutliple lights on a config
    output = config.clone
    button.each do |light|
      output[light] = output[light] == 0 ? 1 : 0
    end
    new_configs << output
  end

end



File.foreach('day10input.txt').with_index do |line, i|

  process_line(line.chomp)
end
