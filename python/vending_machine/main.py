import suica, vending_machine, drink

def main():
    # Step1
    sui = suica.Suica()
    sui.deposit(int(input("チャージ金額："))) # 100円未満は例外発生
    print(f"現在のチャージ残高：{sui.balance}") # 500

    # Step2
    vending = vending_machine.VendingMachine()
    print(f"現在の在庫：{vending.stock()}") # 5, 5, 5
    print()

    # Step3
    target = {1: ["pepsi", 150], 2: ["monster", 150], 3: ["irohasu", 150]}
    print("1: pepsi, 2: monster, 3: irohasu")
    input_no = int(input("購入番号："))
    input_drink = drink.Drink(target[input_no][0], target[input_no][1])
    input_num = int(input("購入数量：")) # チャージ残高ない又は在庫ゼロは例外発生
    vending.buy(input_drink, input_num, sui)
    print(f"現在の在庫：{vending.stock()}")
    print(f"現在の売上：{vending.sales}")
    print(f"現在のチャージ残高：{sui.balance}")
    print()

    # Step4
    print("1: pepsi, 2: monster, 3: irohasu")
    input_no = int(input("在庫番号："))
    input_drink = drink.Drink(target[input_no][0], target[input_no][1])
    input_num = int(input("追加数量："))
    vending.add_stock(input_drink, input_num)
    print(f"現在の在庫：{vending.stock()}")
    print(f"購入可能リスト：{vending.available_list(sui)}")

    # 書き込み不可
    # sui.balance = 1000
    # 書き込み可能
    # sui._balance = 1000

if __name__ == "__main__":
    main()
