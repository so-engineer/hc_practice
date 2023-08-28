# frozen_string_literal: true

input_line = 2
l = []
input_line.times do
  s = gets.chomp.split(',')
  l << s
end

l2 = []
l[0].length.times do |i|
  score = l[1][i].to_i - l[0][i].to_i
  l2 <<
    case score
    when 0
      'パー'
    when -1
      'バーディ'
    when -2
      'イーグル'
    when -3
      'アルバトロス'
    when -4
      'コンドル'
    when -5
      'ホールインワン'
    when 1
      'ボギー'
    else
      "#{score}ボギー"
    end
end
puts l2.join(',')
