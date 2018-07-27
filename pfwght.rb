puts "Hello. What is your name?"
user_name = gets.chomp.capitalize
sleep 1
puts user_name + " ,please, tell me your height in centimeters and I will tell you your ideal weight.=)"
user_height = gets.chomp
pf_weight = user_height.to_i - 110
	if pf_weight > 0 
		puts user_name + " ,your ideal weight is #{pf_weight} kilogramms."
	elsif pf_weight <=0
		puts user_name + " ,your weight is already ideal."
	end