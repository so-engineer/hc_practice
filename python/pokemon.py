# Pythonにもデストラクタはある（ほぼ使ったことがない）
class PokemonDel:
    def __init__(self, name):
        self.name = name

    def __del__(self):
        print(f"{self.name}オブジェクトが破棄されました")

# オブジェクトの作成
pokemon = PokemonDel("リザードン")

# オブジェクトの削除
del pokemon

print("-------------------------------------")
# 継承とポリモーフィズム(同じメソッドで異なる振る舞いをすること)
class Pokemon:
    def __init__(self, name, type1, type2, hp):
        self.name = name
        self.type1 = type1
        self.type2 = type2
        self.hp = hp
    
    def attack(self):
        print(f"{self.name}のこうげき")

class Pikachu(Pokemon):
    def __init__(self, name, type1, type2, hp):
        super().__init__(name, type1, type2, hp)

    def attack(self):
        # super().attack()
        print(f"{self.name}のかいしんのいちげき")

poke = Pikachu("ピカチュウ", "でんき", "むし", "100")
print(poke.name)
poke.attack()

print("-------------------------------------")
# 抽象クラス
# 抽象クラスを継承したクラスは全ての抽象メソッドをオーバーライドしなければならない
from abc import ABC, abstractmethod

class Pokemon(ABC): # ABCクラスの継承

    @abstractmethod # デコレーターを付けて抽象メソッドを定義
    def attack(self):
        pass # passとする

class Zenigame(Pokemon):
    def attack(self): # ここでオーバーライド
        print("みすでっぽう")

poke = Zenigame() # オーバーライドしないとエラーになる
poke.attack()

# ※Pythonにインタフェースを定義するための固有の機能はないが、同じことをクラスを使って実現は可能

print("-------------------------------------")
# カプセル化
class Pokemon:
    def __init__(self):
        self.__name = "myu"

    def __attack(self):
        print("はかいこうせん")

poke = Pokemon()
# poke.__name # アクセス不可
# poke.__attack() # アクセス不可