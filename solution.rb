require 'date'

def solution(s)
  # Step 1: Parse the input string and extract photo information
  lines = s.split("\n")
  photos = lines.map { |line| line.split(', ') }.reject(&:empty?)

  # Step 2: Group photos by city
  city_groups = Hash.new { |hash, key| hash[key] = [] }
  photos.each do |photo_name, city, timestamp|
    city_groups[city] << [photo_name, timestamp]
  end

  # Step 3: Sort them by timestamp
  city_groups.each do |city, group|
    group.sort_by! { |photo| [DateTime.parse(photo[1]), photo[0]] }
  end

  # Step 4: Assign numbers and format new names with leading zeros
  new_names = []
  city_groups.each do |city, group|
    max_num_digits = group.length.to_s.length
    group.each_with_index do |(photo_name, timestamp), idx|
      ext = photo_name.split('.')[1]
      new_name = "#{city}#{(idx + 1).to_s.rjust(max_num_digits, '0')}.#{ext}"
      new_names << ["#{photo_name}, #{city}, #{timestamp}", new_name]
    end
  end

  # Step 5: Replace original names with new names while maintaining order
  new_name_hash = Hash[new_names]
  output_lines = lines.map { |line| new_name_hash[line] || line }.reject(&:nil?)

  output = output_lines.join("\n")
end

# Test the function with the provided example
input_string = <<-INPUT
photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11
INPUT

result = solution(input_string)
puts result
