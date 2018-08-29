puts "This are the mouths in which 30 days:"
months = { "january" => 31, "february" => 28, "march" => 31, "april" => 30, 
  "may" => 31, "june" => 30, "july" => 31, "august" => 31, "september" => 30, 
  "october" => 31, "november" => 30, "december" => 31 }
months.each do |m, d|
  if d%30 == 0
    puts m    
  end
end

puts
#подсмотрено
months.each {|key, value| puts key if value == 30}
