# ファイル名とインポートするモジュール名が同じだとエラーになる

import random

l = ["A", "B", "C", "D", "E", "F"]
n = [2, 3]

for i in range(10):
    group_a = random.sample(l, random.choice(n))
    group_b = set(l) - set(group_a)

    print(f"{i+1}回目--------------------")
    print(sorted(group_a))
    print(sorted(list(group_b)))

