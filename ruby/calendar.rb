# frozen_string_literal: true

require 'optparse'
require 'date'

# 引数の月を取得
opt = OptionParser.new
opt.on('-m') { |v| }
opt.parse!(ARGV)
argv_to_i = ARGV[0].to_i

# 不正な月（引数ブランクを除く）の場合はエラーを返す
target_mon = (1..12).to_a
unless target_mon.include?(argv_to_i) || argv_to_i.zero?
  p '22 is neither a month number (1..12) nor a name'
  raise
end

# 年・月・日などのパラメータを取得
year = Date.today.year
# 引数がなければ今月を返す
mon =
  if ARGV.any?
    argv_to_i
  else
    Date.today.mon
  end
head = Date.new(year, mon).strftime('%-m月 %Y')
first_wday = Date.new(year, mon, 1).wday
last_day = Date.new(year, mon, -1).day

# カレンダーをターミナルに表示
puts head.center(20)
puts '月 火 水 木 金 土 日'
# 一週目のスタート場所を指定
if first_wday.zero?
  print '   ' * 6
else
  print '   ' * (first_wday - 1)
end
# 日付を記述
(1..last_day).each do |date|
  print "#{date.to_s.rjust(2)} " # 日付右寄せ＋余白1
  if first_wday <= 6
    first_wday += 1
  else
    first_wday = 1
    print "\n" # 日曜日まできたら改行
  end
end
print "\n" # %を消すため
