buys = Hash.new
loop do
  puts "Название товара"
  goods = gets.chomp
  break if goods == "stop"
  puts "Цена за единицу"
  price = gets.chomp.to_f
  puts "Количество"
  num = gets.chomp.to_f
  buys [goods] = { price: price, num: num}
end


puts buys.to_s
array = buys.values
puts array
arr = []
array.each { |i| arr << i.values.inject(:*)}
puts "Buys coast " + arr.each.sum.to_s
#завтра переосмыслю и поправлю
