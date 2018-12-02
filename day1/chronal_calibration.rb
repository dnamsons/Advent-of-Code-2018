input = File.open('./freqs.in').read

frequency = 0

input.each_line do |line|
  frequency += line.to_i
end

puts frequency
