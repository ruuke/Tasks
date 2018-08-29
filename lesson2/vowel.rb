vowels = Hash.new
('a'..'z').each_with_index {|letter, index| 
  vowels[letter]=(index+1) if letter =~ /^[aeiou]/}
puts vowels.to_s
