class Solver

  def initialize
    @all_words = []

    File.foreach('input.txt').with_index do |line, i|
      @all_words << line.chomp
    end
  end

  def solve
    solution = ""
    @all_words.each_with_index do |word, i|
      @all_words[i + 1..-1].each_with_index do |other_word, j|
        diff_count = 0
        word.chars.zip(other_word.chars).each do |(letter1, letter2)|
          diff_count += 1 if letter1 != letter2
          break if diff_count > 1
        end
        if diff_count == 1
          puts "#{word} #{i} -  #{other_word} #{j}"
          word.chars.zip(other_word.chars).each do |(letter1, letter2)|
            solution += letter1 if letter1 == letter2
          end
        end
      end
    end
    solution
  end
end


solver = Solver.new
puts solver.solve