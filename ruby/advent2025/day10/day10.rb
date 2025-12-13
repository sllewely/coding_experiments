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

end


File.foreach('day10input.txt').with_index do |line, i|

  process_line(line.chomp)
end
