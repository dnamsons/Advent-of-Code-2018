input = File.open('./claims.in').read

grid = Array.new(1000) { Array.new(1000) { 0 } }

input.each_line do |line|
  dimensions = line.tap { |i| i.slice!(/(.)*@\s/) }.scan(/\d+/).collect!(&:to_i)
  starting_x = dimensions[0]
  starting_y = dimensions[1]
  ending_x = starting_x + dimensions[2]
  ending_y = starting_y + dimensions[3]

  (starting_x...ending_x).each do |x|
    (starting_y...ending_y).each do |y|
      grid[x][y] += 1
    end
  end
end

p grid.flatten.count { |square| square > 1 }
