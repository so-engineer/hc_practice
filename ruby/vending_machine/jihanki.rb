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
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

# 購入処理
class Jihanki
  attr_reader :drinks, :sales

  def initialize
    drinks1 = (1..5).to_a.map { Drink.new(:pepsi, 150) }
    drinks2 = (1..5).to_a.map { Drink.new(:monster, 230) }
    drinks3 = (1..5).to_a.map { Drink.new(:irohasu, 120) }
    @drinks = [drinks1, drinks2, drinks3]
    @sales = 0
  end

  # チャージを参照
  def ref_charge(suica)
    suica.deposit
  end

  # チャージを減らす
  def minus_charge(suica, value)
    suica.deposit -= value
  end

  # 在庫を参照
  def ref_zaiko
    @drinks.map do |i|
      "#{i[0].name}:#{i.size}" if i.count >= 1
    end
  end

  # 在庫を補充
  def add_zaiko(drink)
    target_drink = nil
    @drinks.each do |i|
      target_drink = i if drink.name == i[0].name
    end

    target_drink << drink
  end

  # 購入可能なドリンクのリスト
  def purchase_availval_list(suica)
    dirink_availval_list = []
    @drinks.each do |i|
      dirink_availval_list << i[0].name if i.count >= 1 && i[0].price <= ref_charge(suica)
    end
    dirink_availval_list
  end

  # 購入処理
  def purchase(suica, drink)
    target_drink = nil
    @drinks.each do |i|
      target_drink = i if drink.name == i[0].name
    end
    if target_drink[0].price > ref_charge(suica) || target_drink.empty?
      raise 'チャージ残高が足りない、もしくは在庫がありません。'
    else
      @sales += target_drink[0].price
      minus_charge(suica, target_drink[0].price)
      target_drink.delete_at(-1)
    end
  end
end

suica = Suica.new
jihanki = Jihanki.new
drink = Drink.new(:pepsi, 150)
# チャージを参照
p "チャージ残高:#{jihanki.ref_charge(suica)}"
# 任意の金額をチャージ
suica.charge(1000)
p "チャージ残高:#{jihanki.ref_charge(suica)}←任意の金額をチャージ"
# 在庫を参照
p "在庫:#{jihanki.ref_zaiko}"
# 在庫を補充
jihanki.add_zaiko(drink)
p "在庫:#{jihanki.ref_zaiko}←在庫を補充"
# 購入処理
jihanki.purchase(suica, drink)
p 'pepsiを購入----------------------------------------------------------'
p "在庫:#{jihanki.ref_zaiko}"
p "売上金額:#{jihanki.sales}"
p "チャージ残高:#{jihanki.ref_charge(suica)}"
p "購入可能なドリンクのリスト:#{jihanki.purchase_availval_list(suica)}"
p 'monsterを購入--------------------------------------------------------'
drink = Drink.new(:monster, 230)
jihanki.purchase(suica, drink)
p "在庫:#{jihanki.ref_zaiko}"
p "売上金額:#{jihanki.sales}"
p "チャージ残高:#{jihanki.ref_charge(suica)}"
p "購入可能なドリンクのリスト:#{jihanki.purchase_availval_list(suica)}"
p 'irohasuを購入--------------------------------------------------------'
drink = Drink.new(:irohasu, 120)
jihanki.purchase(suica, drink)
p "在庫:#{jihanki.ref_zaiko}"
p "売上金額:#{jihanki.sales}"
p "チャージ残高:#{jihanki.ref_charge(suica)}"
p "購入可能なドリンクのリスト:#{jihanki.purchase_availval_list(suica)}"
p 'irohasuを0本になるまで購入---------------------------------------------'
drink = Drink.new(:irohasu, 120)
jihanki.purchase(suica, drink)
drink = Drink.new(:irohasu, 120)
jihanki.purchase(suica, drink)
drink = Drink.new(:irohasu, 120)
jihanki.purchase(suica, drink)
drink = Drink.new(:irohasu, 120)
jihanki.purchase(suica, drink)
p "購入可能なドリンクのリスト:#{jihanki.purchase_availval_list(suica)}"
p "在庫:#{jihanki.ref_zaiko}"
p "売上金額:#{jihanki.sales}"
p "チャージ残高:#{jihanki.ref_charge(suica)}"
p "購入可能なドリンクのリスト:#{jihanki.purchase_availval_list(suica)}"
