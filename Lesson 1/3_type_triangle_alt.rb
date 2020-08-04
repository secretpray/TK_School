# Задача 3
# Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет,
# является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru), равнобедренным
# (т.е. у него равны любые 2 стороны)  или равносторонним (все 3 стороны равны) и выводит результат на экран.
# Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза)
# и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. Если все 3 стороны равны,
# то треугольник равнобедренный и равносторонний, но не прямоугольный.

puts "Определяем тип треугольника..."

print ("Введите длину первой стороны: ")
a = gets.chomp.to_f
print ("Введите длину второй стороны: ")
b = gets.chomp.to_f
print ("Введите длину третьей стороны: ")
c = gets.chomp.to_f

# triangle = [a, b, c].sort!
# side_a = triangle[0]
# side_b = triangle[1]
# side_c = triangle.last # hypotenuse
side_a, side_b, side_c = [a, b, c].sort! # side_c после сортироки - гипотенуза

if side_a == 0 || side_b == 0 || side_c == 0
  puts 'Введите корректные данные...'
elsif side_a == side_b && side_a == side_c
  puts 'Треугольник равносторонний, но не прямоугольный'
elsif side_c**2 == side_a**2 + side_b**2
  print ('Треугольник прямоугольный!')
  puts ' К тому же равнобедренный.' if side_a == side_b
elsif side_a == side_b
  puts 'Треугольник равнобедренный, но не прямоугольный.'
else
  print ('Обычный, ничем не примечательный треугольник.')
  puts ' Треугольник не является прямоугольным!'
end
# STDIN.getc # чтобы избежать проблем при запуске программы c переданным аргументом
# (http://ruby.qkspace.com/ruby-chem-gets-otlichaetsya-ot-stdin-gets)