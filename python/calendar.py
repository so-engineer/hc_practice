import argparse
import datetime
import sys


# 今年・今月の設定
current_year = datetime.date.today().year
current_month = datetime.date.today().month

# -mオプションの設定
def parser():
    # オブジェクト生成
    parser = argparse.ArgumentParser()
    # 引数設定
    parser.add_argument("-m", "--month", type=int)
    # 引数解析
    args = parser.parse_args()

    return args

# 当月初のスタート位置を調整
def start(num):
    if num == 1:
        return ""
    if num == 2:
        return "    "
    if num == 3:
        return "        "
    if num == 4:
        return "            "
    if num == 5:
        return "                "
    if num == 6:
        return "                    "
    if num == 0:
        return "                        "

# メインロジックの実行
def execute(year=current_year, month=current_month):
    try:
        dt = datetime.datetime(year, month, 1)
    except ValueError:
        sys.exit(f"{month} is neither a month number (1..12) nor a name")

    # 月と年を表示
    m = str(dt.month)+"月"
    print(m.rjust(11), end="")
    y = dt.strftime("%Y")
    print(y.rjust(5))

    # 曜日を表示
    dict_weekday = {1: "月", 2: "火", 3: "水", 4: "木", 5: "金", 6: "土", 0: "日"}
    for k, v in dict_weekday.items():
        print(v, end="  ")

    # 当月初の算定
    month_first_day = dt.date() - datetime.timedelta(days=dt.day - 1)

    # 当月末の算定（翌月初から1を引く）
    if dt.month == 12:
        next_month_first_day = dt.date().replace(day=1, month=1, year=dt.year + 1)
    else:
        next_month_first_day = dt.date().replace(day=1, month=dt.month + 1)

    month_last_day = next_month_first_day - datetime.timedelta(days=1)

    # 当月初の曜日を数字で取得
    num = month_first_day.weekday()

    # 日付を表示
    for day in range(month_first_day.day, month_last_day.day):
        # 日付が一桁の場合、二桁に変換
        if day < 10:
            day = f"0{day}"
        else:
            day = str(day)
        
        # 当月初のスタート位置を調整
        if day == "01":
            print()
            print(start(num), end="")
        
        # 日曜日になったら折り返す
        if num == 0 or num == 7:
            print(day, end="  ")
            print()
            num = 1
            continue
        else:
            num += 1

        print(day, end="  ")


if len(sys.argv) == 1:
    execute()
else:
    execute(month=parser().month)
