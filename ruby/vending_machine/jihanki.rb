# frozen_string_literal: true

# Suica
class Suica
  attr_reader :deposit
  attr_writer :deposit

  def initialize
    @deposit = 500
  end

  # チャージする
  def charge(value)
    raise '無効なチャージ金額です' if value < 100

    @deposit += value
  end
end

# ジュースの管理
class Drink
  attr_reader :name, :price, :count
  attr_writer :count

  def initialize(name, price, count)
    @name = name
    @price = price
    @count = count
  end
end

# 購入処理
class Jihanki
  attr_reader :suica, :drink, :sales

  def initialize
    @suica = Suica.new
    @drink1 = Drink.new(:pepsi, 150, 5)
    @drink2 = Drink.new(:monster, 230, 5)
    @drink3 = Drink.new(:irohasu, 120, 5)
    @drinks = [@drink1, @drink2, @drink3]
    @sales = 0
  end

  # 購入可能なドリンクのリスト
  def purchase_availval_list
    dirink_availval_list = []
    @drinks.each do |drink|
      dirink_availval_list << drink.name if drink.price <= @suica.deposit && drink.count >= 1
    end

    dirink_availval_list
  end

  # 在庫の一覧
  def zaiko_list
    zaiko_list = []
    @drinks.each do |drink|
      zaiko_list << "#{drink.name}:#{drink.count}"
    end

    zaiko_list
  end

  # 在庫を補充
  def add_zaiko(kind, value)
    @drinks.each do |drink|
      drink.count += value if kind == drink.name
    end
  end

  # 購入処理
  def purchase(kind, number)
    target_drink = nil
    @drinks.each do |drink|
      target_drink = drink if kind == drink.name
    end
    buy_price = target_drink.price * number
    # ジュース値段以上のチャージ残高がある条件下
    if buy_price <= @suica.deposit
      target_drink.count -= number
      @sales += buy_price
      @suica.deposit -= buy_price
    elsif buy_price > @suica.deposit || number > target_drink.count
      raise "チャージ残高が足りない、もしくは在庫がありません。チャージ残高:#{@suica.deposit} 在庫:#{target_drink.count}"
    end
  end
end

jihanki = Jihanki.new
# 購入処理
jihanki.purchase(:pepsi, 3)
# 任意の金額をチャージ
jihanki.suica.charge(100)
# 在庫を補充
jihanki.add_zaiko(:irohasu, 5)

p "現在のチャージ残高:#{jihanki.suica.deposit}"
p "在庫:#{jihanki.zaiko_list}"
p "現在の売上金額:#{jihanki.sales}"
p "購入可能なドリンクのリスト:#{jihanki.purchase_availval_list}"
