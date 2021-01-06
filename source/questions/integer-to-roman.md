---
title: Integer to Roman / Roman to Integer 
date: 2017-11-09 16:44:09
toc: true
---
整型、罗马数字互转。<!--more-->

# 题目 12 

Given an integer, convert it to a roman numeral.

Input is guaranteed to be within the range from 1 to 3999.

# 题目 13

Given a roman numeral, convert it to an integer.

Input is guaranteed to be within the range from 1 to 3999.

# 分析

摸清罗马数字的规律。[罗马数字wiki](https://zh.wikipedia.org/wiki/%E7%BD%97%E9%A9%AC%E6%95%B0%E5%AD%97)

| index | 0 | 1 | 2 | 3 | 4 | 5 | 6 |
| - | - | - | - | - | - | - | - |
| Roman | I | V | X | L | C | D | M |
| value | 1 | 5 | 10 | 50 | 100 | 500 | 1000 | 

t = 1, 3, 5  个位与IVX有关，十位与XLC有关，百位与CDM有关。

| 余数  | 该位对应的罗马数字 |
| :---- |:---------------- |
| 0     |                  |
| 1 - 3 | (t-1)...(t-1)    |
| 4     | (t-1)(t)         |
| 5 - 8 | (t)(t+1)...(t+1) |
| 9     | (t-1)(t+1)       |

# 解决

Int To Roman：根据数字符号的对应规律，从高位数字开始转换

```cpp
string intToRoman(int num) {
    char roman[7] = {'I','V','X','L','C','D','M'};
    int t = 1;
    string res = "";
    do {
        string str = "";
        int x = num % 10;
        if (!x) {
            t += 2;
            num /= 10;
            continue;
        }
        if (x < 4) 
            for (int i = 0; i < x; i++)
                str += roman[t - 1];
        if (x == 4) {
            str += roman[t - 1];
            str += roman[t];
        }
        if (x > 4 && x < 9) {
            str += roman[t];
            for (int i = 0; i < x - 5; i++)
                str += roman[t - 1];
        }
        if (x == 9) {
            str += roman[t - 1];
            str += roman[t + 1];
        }

        t += 2;
        num /= 10;
        res.insert(0, str);     //把每一位求得的编码从头插入，不然会倒序
    } while (num);
    return res;
}
```

Roman To Int：一个个字符地转成数字意义

```cpp
int romanToInt(string s) {
    int res = 0;
    unordered_map<char, int> map;
    map['I'] = 1;
    map['V'] = 5;
    map['X'] = 10;
    map['L'] = 50;
    map['C'] = 100;
    map['D'] = 500;
    map['M'] = 1000;
    bool start = true;//
    int i = 1;
    for (; i < s.size(); i++) {
        res += toInt(map[s[i - 1]], map[s[i]], start);
    }
    if(start) res += map[s[i - 1]];
    return res;
}
int toInt(int a, int b, bool &start) {
    int t = 0;
    if (a >= b && a / b < 10) {
        t += b;
        if (start) {
            t += a;
        }
        start = false;
    }
    else if (b > a) {
        t += b - a;
        start = false;
    }
    else if (start)
        t += a;
    else 
        start = true; 
    return t;
}
```
