# Корзина товаров

basket={}
loop do
  puts "Введите название товара или stop для окончания ввода"
  product = gets.chomp
  break if product.downcase == "stop"
  puts "Введите цену за единицу товара"
  price = gets.chomp.to_f
  puts "Введите количество товара"
  amount = gets.chomp.to_f
  basket[product]={ price: price, amount: amount }
end
puts basket
grand_total = 0
basket.each do |product,vals|
  total = vals[:price]*vals[:amount]
  grand_total += total
  puts "Итого по товару #{product}: #{total}"
end

puts "Итого по всем товарам: #{grand_total}"

