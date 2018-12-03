input = File.open('./claims.in').read

grid = Array.new(1000) { Array.new(1000) { [0] } }

ids = []

input.each_line do |line|
  dimensions = line.scan(/\d+/).collect!(&:to_i)
  ids << dimensions[0]
  starting_x = dimensions[1]
  starting_y = dimensions[2]
  ending_x = starting_x + dimensions[3]
  ending_y = starting_y + dimensions[4]

  (starting_x...ending_x).each do |x|
    (starting_y...ending_y).each do |y|
      grid[x][y][0] == 0 ? grid[x][y][0] = dimensions[0] : grid[x][y] << dimensions[0]
    end
  end
end

grid = grid.flatten(1)

ids.each do |id|
  claim_squares = grid.select { |i| i.include? id }

  if claim_squares.count == claim_squares.count { |square| square.count == 1 }
    p id
    break
  end
end
