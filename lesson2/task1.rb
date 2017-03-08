# Количество дней в месяце

months={"Январь" => 31,
        "Февраль" => 28,
        "Март" => 31,
        "Апрель" => 30,
        "Май" => 31,
        "Июнь" => 30,
        "Июль" => 31,
        "Август" => 31,
        "Сентябрь" => 30,
        "Октябрь" => 31,
        "Ноябрь" => 30,
        "Декабрь" => 31
}

months_30_days = months.select { |m,d| d==30 }
puts "Месяцы с количеством дней, равным 30:"
months_30_days.each do |m,d|
  puts m
end
