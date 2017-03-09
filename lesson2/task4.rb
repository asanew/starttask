# Порядковые номера гласных букв

vowels = ['e','y','u','i','o','a']
letters = {}
('a'..'z').each_with_index { |l,i| letters[l]=i+1 }
vowel_letters = letters.select { |k,v| vowels.include? k }
puts "Гласные буквы с их номерами: "
puts vowel_letters

