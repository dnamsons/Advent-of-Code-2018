require 'time'
require 'irb'

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

minute_sleep_freq = {guard_id: nil, minute: "", minute_occurence_count: 0}

time_table.each_key do |k|
  p time_table[k].max_by { |i| i.count }
  key_max = time_table[k].max_by { |k, v| v }
  if key_max && key_max[1] > minute_sleep_freq[:minute_occurence_count]
    minute_sleep_freq[:guard_id] = k
    minute_sleep_freq[:minute] = key_max[0]
    minute_sleep_freq[:minute_occurence_count] = key_max[1]
  end
end

p minute_sleep_freq[:guard_id].tr('#', '').to_i * minute_sleep_freq[:minute].to_i
