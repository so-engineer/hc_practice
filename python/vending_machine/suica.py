class Suica:
    def __init__(self):
        self.__balance = 500

    # ゲッターにより読み込みを出来るようにする
    @property
    def balance(self):
        return self.__balance
    
    # セッターにより特定の条件下で書き込みを出来るようにする
    @balance.setter
    def balance(self, value):
        self.__balance = value

    def deposit(self, num):
        if num < 100:
            raise
        self.__balance += num
