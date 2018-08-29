puts "Введите год своего рождения"
year = gets.chomp.to_i
puts "Введите месяц своего рождения"
month = gets.chomp.to_i
puts "Введите день своего рождения"
day = gets.chomp.to_i
bday = Time.mktime(year, month, day)
ser_num = (bday - Time.mktime(year, 1, 1)) / (24*60*60)
puts ser_num + 1
=begin
if month <= 2
  puts ser_num +1
elsif month > 2 && year%100 == 0 && year%400 != 0
  puts ser_num +1
elsif month > 2 && year%4 == 0 || year%400 == 0
  puts ser_num + 1
else
  puts ser_num + 1
end
=end # похоже класс тайм сам знает о високосных годах

#ну и красивое решение, которое я подсмотрел
puts

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
puts "Введите год своего рождения"
year = gets.chomp.to_i
puts "Введите месяц своего рождения"
month = gets.chomp.to_i
puts "Введите день своего рождения"
day = gets.chomp.to_i

year_4 = year % 400 == 0 || year % 4 == 0 && year % 100 != 0
months[1] = 29 if year_4

ser_num = 0
ser_num += months.take(month - 1).sum if month > 1
ser_num += day

puts ser_num
