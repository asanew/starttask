# Порядковые номера гласных букв

vowels = %w( e y u i o a ) #['e','y','u','i','o','a']
#letters = {}
#('a'..'z').each_with_index { |l,i| letters[l]=i+1 }
#vowel_letters = letters.select { |k,v| vowels.include? k }
vowel_letters = {}
('a'..'z').each.with_index(1) { |l,i| vowel_letters[l] = i if vowels.include? l }
puts "Гласные буквы с их номерами: "
puts vowel_letters

