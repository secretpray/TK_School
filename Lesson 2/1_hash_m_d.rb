# 1) Сделать хеш, содержащий месяцы и количество дней в месяце.
# В цикле выводить те месяцы, у которых количество дней ровно 30

month_day = {
    "январь" => 31,
    "февраль" => 28,
    "март" => 31,
    "апрель" => 30,
    "май" => 31,
    "июнь" => 30,
    "июль" => 31,
    "август" => 31,
    "сентябрь" => 30,
    "октябрь" => 31,
    "ноябрь" => 30,
    "декабрь" => 31
}

puts "Месяцы, у которых количество дней ровно 30:"

# Вариант 1.1
month_day.each { |month, days| puts "- #{month}" if days == 30 } # можно month_day.each_pair

# Вариант 2
# month_day.each_key {|month| puts "- #{month}" if month_day[month] == 30 }

#  months = { 31 => ["January", " March", "May", "July", "August", "October", "December"],
#            30 => ["April", "June", "September", " November"],
#            28 => ["February"] }
#
# months[30].each { |e| print e + " " }






