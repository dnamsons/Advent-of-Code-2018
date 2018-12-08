require 'time'

def get_action(line)
  if line.include?('asleep')
    :fell_asleep
  elsif line.include?('wakes')
    :woke_up
  elsif line.include?('Guard')
    line.slice(/#\d+/)
  end
end

def get_time(line)
  Time.parse(line.slice(/\[(.)+\]/))
end

def get_minute(time)
  time.strftime('%M').to_i
end

input = File.open('./record.in').read.split("\n")
input.map! { |line| [get_time(line), get_action(line)] }.sort! { |x, y| x[0] <=> y[0] }

guard_hash = Hash.new(0)
time_table = Hash.new()

current_id = nil

input.each_with_index do |record, index|
  case record[1]
  when :fell_asleep
    next
  when :woke_up
    guard_hash[current_id] += ((input[index][0] - input[index - 1][0]) / 60)
    ((get_minute(input[index - 1][0]))...(get_minute(input[index][0]))).each { |i| time_table[current_id][i.to_s] += 1 }
  else
    current_id = record[1]
    time_table[current_id] = Hash.new(0) unless time_table[current_id]
    next
  end
end

the_guard_id = guard_hash.max_by {|k, v| v }[0].tr('#', '').to_i
the_minute = time_table["##{the_guard_id}"].max_by { |k, v| v }[0].to_i

p the_guard_id * the_minute
