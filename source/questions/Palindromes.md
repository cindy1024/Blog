---
title: Palindrome Number
date: 2017-08-12 17:44:44
toc: true
---

判断字符串是否为回文串或镜像串。<!--more-->

# [题目 401](https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=342) 

### Input

Input consists of strings (one per line) each of which will consist of one to twenty valid characters.There will be no invalid characters in any of the strings. Your program should read to the end of file.

### Output

For each input string, you should print the string starting in column 1 immediately followed by exactly one of the following strings.

### Sample Input

NOTAPALINDROME
ISAPALINILAPASI
2A3MEAS
ATOYOTA

### Sample Output

NOTAPALINDROME -- is not a palindrome.<br/>
ISAPALINILAPASI -- is a regular palindrome.<br/>
2A3MEAS -- is a mirrored string.<br/>
ATOYOTA -- is a mirrored palindrome.

**Note** 

- **‘0’ (zero)** and ‘O’ (the letter) are considered the same character and therefore ONLY the letter ‘O’ is a valid character.
- The output line is to include **the ‘-’s and spacing** exactly as shown in the table above and demonstrated in the Sample Output below.
- In addition, after each output line, you must print **an empty line**.

# 分析

依次首尾比较。

# 解决

用string数组存储输出信息，用p * 2 + m计算标志位来输出信息。

```cpp
#include <string>
#include <iostream>
using namespace std;

const string reverse = "A   3  HIL JM O   2TUVWXY51SE Z  8 ";
const string message[4] = { "not a palindrome","a mirrored string","a regular palindrome","a mirrored palindrome" };

char mirror(char ch) {
    if (ch >= 'A' && ch <= 'Z') return reverse[ch - 'A'];
    if (ch >= '0' && ch <= '9') return reverse[ch - '0' + 25];
}

int main() {
    string s;
    while(cin >> s) {
        bool p, m;
        p = m = true;
        int len = s.size();

        for (int i = 0; i < len; i++) {
            if (s[i] != s[len - i - 1]) p = false;
            if (s[i] != mirror(s[len - i - 1])) m = false;
        }
        cout << s << " -- is " << message[p * 2 + m] << "." <<endl <<endl;
    }
    return 0;
}
```



