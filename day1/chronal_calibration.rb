input = File.open('./freqs.in').read

frequency = 0

input.each_line do |line|
  line_number = line.scan(/[-+]\d+/).first
  frequency += line_number.to_i
end

puts frequency
