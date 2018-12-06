input = File.open('./polymer.in').read.chomp

def same_character?(char1, char2)
  char1.downcase == char2.downcase
end

def is_upper?(character)
  character == character.to_s.capitalize
end

def both_not_upper?(char1, char2)
  (is_upper?(char1) && !is_upper?(char2)) || (!is_upper?(char1) && is_upper?(char2))
end

def polymer_amount_after_reactions(input)
  i = 0
  loop do
    if same_character?(input[i], input[i + 1]) && both_not_upper?(input[i], input[i + 1])
      input.tap { |a| a.slice!(i..(i + 1)) }
      i -= 1 unless i == 0
    else
      i += 1
    end

    break if i == input.length - 1
  end

  input.length
end

min = input.length

('a'..'z').each do |char|
  charless_length = polymer_amount_after_reactions(input.delete("#{char}#{char.capitalize}"))
  min = charless_length if charless_length < min
end

p min
