array = []
for i in (10..100) do
  if i%5 == 0
    array << i
  end
end
puts array.to_s

#подсмотрено, переосмыслено 

a = (10..100).step(5).to_a
puts a.to_s
