# テキストをリストで読み取り
input_line = 2 # 2行を指定
l = []
for _ in range(input_line):
    s = input().strip().split(',') # 空白を取り除き,で分割してリストを返す
    l.append(s)

rule = {0: "パー", -1: "パーディ", -2: "イーグル", -3: "アルバトロス", -4: "コンドル", 1: "ボギー"}

# メインロジックの実行
i = 0
l_score = []
for i in range(len(l[0])):
    score = int(l[1][i]) - int(l[0][i])

    if score >= 2:
        l_score.append(f"{score}ボギー")
    elif int(l[0][i]) == 5 and int(l[1][i]) == 1:
        l_score.append("コンドル")
    elif int(l[1][i]) == 1:
        l_score.append("ホールインワン")
    else:
        l_score.append(rule[score])
    
    i += 1

# リストを,で区切って文字列化
output = ",".join(l_score)
print(output)