puts "Программа вычисляет дискриминант (D) и корни (x1, x2) 
квадратного уравнения ax^2+bx+c=0."
puts "Введите коэффициент (a)"
a = gets.chomp.to_f
puts "Введите коэффициент (b)"
b = gets.chomp.to_f
puts "Введите коэффициент (a)"
c = gets.chomp.to_f
D = (b**2 - 4*a*c)
x1 = (-b+D**0.5)/(2*a)
x2 = (-b-D**0.5)/(2*a)
if D < 0
	puts "D = #{D}"
	puts "Корни уравнения являются комплексными числами."
	puts "x1 = #{x1}"
	puts "x2 = #{x2}"
elsif D == 0
	puts "D = #{D}"
	puts "x = #{x1}"
else
	puts "D = #{D}"
	puts "x1 = #{x1}"
	puts "x2 = #{x2}"
end
puts
