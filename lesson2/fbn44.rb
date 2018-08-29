=begin
array = [1, 1]
for i in array do
  if i < 3
    array << 1
  else
    fib = ((i-1) + (i-2))
    array << fib  
  end
end
puts array
=end
# думал решить через условие, но как передавать значение в массив и потом из него брать
# не понял
# про рекурсию в методах читаю в учебнике криса пайна, попыток было много,
# но решение в нете нашел

def fib(n)
  if n < 3
    1
  else
    fib(n - 1) + fib(n - 2)
  end
end
a = []
(1..11).each {|n| a << fib(n) }
puts a.to_s
puts

#подсмотрено, переосмыслено
array = [1, 1]
loop do
  fibo = array.last(2).sum
  break if fibo >=100
  array << fibo
end
puts array.to_s
