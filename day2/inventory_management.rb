def exactly_n_times_repeated_letter?(id, n)
  id.each_char.find { |letter| id.count(letter) == n }
end

with_two_letters = 0
with_three_letters = 0

crate_ids = File.open('./crate_ids.in').read

crate_ids.each_line do |crate_id|
  with_two_letters += 1 if exactly_n_times_repeated_letter?(crate_id, 2)
  with_three_letters += 1 if exactly_n_times_repeated_letter?(crate_id, 3)
end

puts with_two_letters * with_three_letters
