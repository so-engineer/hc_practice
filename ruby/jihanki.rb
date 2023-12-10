# frozen_string_literal: true

# Suica
class Suica
  attr_reader :deposit

  def initialize
    @deposit = 500
  end

  def charge_in(value)
    raise '無効なチャージ金額です' if value < 100

    @deposit += value
  end

  def charge_out(value)
    @deposit -= value
  end
end

# ジュースの管理
class Juice
  attr_reader :drink, :drink_count

  def initialize
    @drink = { pepsi: 150, monster: 230, irohasu: 120 }
    @drink_count = { pepsi: 5, monster: 5, irohasu: 5 }
  end

  def zaiko_in(kind, number)
    @drink_count[kind] += number
  end

  def zaiko_out(kind, number)
    @drink_count[kind] -= number
  end
end

# 購入処理
class Buy
  attr_reader :suica, :juice, :sales

  def initialize
    @suica = Suica.new
    @juice = Juice.new
    @sales = 0
  end

  def purchase(kind, number)
    buy_price = @juice.drink[kind] * number
    # ジュース値段以上のチャージ残高がある条件下
    if buy_price <= @suica.deposit
      @juice.zaiko_out(kind, number)
      @sales += buy_price
      @suica.charge_out(buy_price)
    elsif buy_price > @suica.deposit || number > @juice.drink_count[kind]
      raise "チャージ残高が足りない、もしくは在庫がありません。チャージ残高:#{@suica.deposit} 在庫:#{@juice.drink_count[kind]}"
    end
  end

  def purchase_availval_list
    dirink_availval_list = []
    @juice.drink.each do |k, v|
      dirink_availval_list << k if v <= @suica.deposit && @juice.drink_count[k] > 1
    end

    dirink_availval_list
  end
end

buy = Buy.new
buy.purchase(:pepsi, 3)
# 任意の金額をチャージ
buy.suica.charge_in(100)
# 在庫を補充
buy.juice.zaiko_in(:irohasu, 5)

p "現在のチャージ残高:#{buy.suica.deposit}"
p "在庫:#{buy.juice.drink_count}"
p "現在の売上金額:#{buy.sales}"
p "購入可能なドリンクのリスト:#{buy.purchase_availval_list}"
