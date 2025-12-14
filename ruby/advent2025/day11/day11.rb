File.foreach('day10input.txt').with_index do |line, i|

  process_line(line.chomp)
end