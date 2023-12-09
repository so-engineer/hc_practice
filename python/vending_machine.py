class Suica:
    def __init__(self):
        self._balance = 500

    # ゲッターにより読み込みは出来るが書き込みは出来ないようにする
    @property
    def balance(self):
        return self._balance

    def deposit(self, num):
        if num < 100:
            raise

        self._balance += num

class VendingMachine:
    def __init__(self):
        self.drink_pepsi = [Drink("pepsi", 150) for _ in range(5)]
        self.drink_monster = [Drink("monster", 150) for _ in range(5)]
        self.drink_irohasu = [Drink("irohasu", 150) for _ in range(5)]
        self.drink_all = [self.drink_pepsi, self.drink_monster, self.drink_irohasu]
        self._sales = 0

    @property
    def sales(self):
        return self._sales

    def target_drink(self, drink: object):
        for i in self.drink_all:
            if i[0].name == drink.name:
                target_drink = i
        
        return target_drink

    def buy(self, drink: object, num, suica: object):
        if len(self.target_drink(drink)) < num:
            raise

        for _ in range(num):
            self.target_drink(drink).pop()

        self._sales += int(drink.price) * num

        suica._balance -= int(drink.price) * num
        if suica._balance < 0:
            raise

    def available_list(self, suica: object):
        available_list = []
        for drink in self.drink_all:
            if (suica.balance >= drink[0].price) \
                and (len(drink) > 0):
                available_list.append(drink[0].name)
        
        return available_list
    
    def stock(self):
        stock_list = []
        for drink in self.drink_all:
            drink_list = f"({drink[0].name}：{len(drink)})"
            stock_list.append(drink_list)
        
        return stock_list
    
    def add_stock(self, drink: object, num):
        for _ in range(num):
            self.target_drink(drink).append(drink)

class Drink:
    def __init__(self, name, price):
        self.name = name
        self.price = price

# Step1
suica = Suica()
suica.deposit(int(input("チャージ金額："))) # 100円未満は例外発生
print(f"現在のチャージ残高：{suica.balance}") # 500

# Step2
vending = VendingMachine()
print(f"現在の在庫：{vending.stock()}") # 5, 5, 5
print()

# Step3
target = {1: ["pepsi", 150], 2: ["monster", 150], 3: ["irohasu", 150]}
print("1: pepsi, 2: monster, 3: irohasu")
input_no = int(input("購入番号："))
input_drink = Drink(target[input_no][0], target[input_no][1])
input_num = int(input("購入数量：")) # チャージ残高ない又は在庫ゼロは例外発生
vending.buy(input_drink, input_num, suica)
print(f"現在の在庫：{vending.stock()}")
print(f"現在の売上：{vending.sales}")
print(f"現在のチャージ残高：{suica.balance}")
print()

# Step4
print("1: pepsi, 2: monster, 3: irohasu")
input_no = int(input("在庫番号："))
input_drink = Drink(target[input_no][0], target[input_no][1])
input_num = int(input("追加数量："))
vending.add_stock(input_drink, input_num)
print(f"現在の在庫：{vending.stock()}")
print(f"購入可能リスト：{vending.available_list(suica)}")

