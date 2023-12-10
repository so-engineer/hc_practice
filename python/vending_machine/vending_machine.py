import drink

class VendingMachine:
    def __init__(self):
        self.drink_pepsi = [drink.Drink("pepsi", 150) for _ in range(5)]
        self.drink_monster = [drink.Drink("monster", 150) for _ in range(5)]
        self.drink_irohasu = [drink.Drink("irohasu", 150) for _ in range(5)]
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

        suica.balance -= int(drink.price) * num
        if suica.balance < 0:
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
