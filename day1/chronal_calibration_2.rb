input = File.open('./freqs.in').read

frequency_changes = input.scan(/[-+]\d+/).collect! &:to_i

frequency = 0
frequencies = []
i = 0

until frequencies.include?(frequency)
  frequencies << frequency
  frequency += frequency_changes[i]
  i == frequency_changes.length - 1 ? i = 0 : i += 1
end

puts frequency
