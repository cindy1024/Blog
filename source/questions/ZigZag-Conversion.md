---
title: ZigZag Conversion
date: 2017-08-03 11:05:31
toc: true
---
把字符串转换成之字形，重新读取字串。<!--more-->

# 题目 6

The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

```
P   A   H   N
A P L S I I G
Y   I   R  
```

And then read line by line: `"PAHNAPLSIIGYIR"`
Write the code that will take a string and make this conversion given a number of rows:

```
string convert(string text, int nRows);
```

`convert("PAYPALISHIRING", 3)` should return `"PAHNAPLSIIGYIR"`.

# 分析

找规律题

# 解决

每行的首字母之后都依次分析第一个字母`(nRows-1-i)*2`、第二个字母`(nRows-1)*2`，繁琐。

```cpp
    string convert(string text, int nRows) {
        int l_space, r_space, l_letter, r_letter;
        int t;
        string res;
        if(nRows == 1) return text;
        for (int i = 0; i < nRows; i++)
        {
            l_letter = (nRows - 1 - i) * 2;
            r_letter = 2 * i;
            t = i;

            res.push_back(text[t]);
            while (t + l_letter < text.length()) {

                if (l_letter != 0) res.push_back(text[t + l_letter]);
                if (t + (nRows - 1) * 2 >= text.length()) break;    //若第二个字母超出范围，本行已经到末尾

                if (r_letter != 0) res.push_back(text[t + l_letter + r_letter]);
                t = t + (nRows - 1) * 2;    //更新某行的当前标记
                if (t == 0) break;  //只有一个字符
            }

        }
        return res;
    }
```

# 参考

间隔列固定 `2*numRows-2`，（除了首行和末尾行）中间字母规律`2*(numRows-1-i)`。

```cpp
    class Solution {
    public:
        string convert(string s, int numRows) {
            if(numRows==1) return s;
            string rel="";
            int l=s.length();
            int add=2*numRows-2;
            for(int i=0;i<numRows;i++){
                for(int j=i;j<l;j+=add){    //把步长增加放到for循环中
                    rel+=s[j];              //固定列字母
                    int flag=j+2*(numRows-1-i);
                    if(i!=0&&i!=numRows-1&&flag<l){     //非首尾行，且 flag<l
                        rel+=s[flag];       //中间字母
                    }
                }
            }
            return rel;
        }
    };
```

