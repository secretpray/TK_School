# Задача 2
# Площадь треугольника. Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле:
# 1/2*a*h. Программа должна запрашивать основание и высоту треугольника и возвращать его площадь

puts 'Для расчета площади треугольника укажите его основание и высоту.'

puts 'Введите основание треугольника (см): '
baseTriangle = gets.chomp.to_f

puts 'Введите высоту треугольника (см):'
heightTriangle = gets.chomp.to_f

triangleArea = 0.5 * baseTriangle * heightTriangle  # есть ли смысл помещать в скобки? Вычисления справа налево, но я бы поставил)))

if triangleArea <= 0
  puts 'Введите корректные данные, пожалуйста!'
else
  puts "Площадь треугольника с основанием #{baseTriangle} см и высотой #{heightTriangle} см равна: #{triangleArea} кв. см"
end
# STDIN.getc # чтобы избежать проблем при запуске программы c переданным аргументом
# (http://ruby.qkspace.com/ruby-chem-gets-otlichaetsya-ot-stdin-gets)
