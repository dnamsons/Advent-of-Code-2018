def find_similar_id(id_arr)
  length = id_arr.length - 1

  (0...length).each do |base|
    ((base + 1)..length).each do |iter|
      similar = make_if_similar(id_arr[base], id_arr[iter])
      return similar if similar
    end
  end
end

def make_if_similar(a, b)
  diff = []
  (0..(a.length - 1)).each do |n|
    diff << n if a[n] != b[n]
    return nil if diff.length > 1
  end

  a.tap { |id| id.slice!(diff.first) }
end

crate_ids = File.open('./crate_ids.in').read

crate_id_array = []

crate_ids.each_line do |crate_id|
  crate_id_array << crate_id
end

puts find_similar_id(crate_id_array)
