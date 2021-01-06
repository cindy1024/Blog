---
title: String to Integer
date: 2017-08-03 19:02:17
mathjax: true
toc: true
---
实现atoi函数。<!--more-->

# 题目 8

Implement atoi to convert a string to an integer.

**Hint:** Carefully consider all possible input cases. If you want a challenge, please do not see below and ask yourself what are the possible input cases.

**Notes:** It is intended for this problem to be specified vaguely (ie, no given input specs). You are responsible to gather all the input requirements up front.

If no valid conversion could be performed, a zero value is returned. If the correct value is out of the range of representable values, INT_MAX (2147483647) or INT_MIN (-2147483648) is returned.

# 分析

>**atoi (ascii to integer)**把字符串转换成整型数。跳过前面的空白字符（例如空格，tab缩进等。可以通过isspace( )函数来检测），直到遇上数字或正负符号才开始做转换，而在遇到非数字或字符串结束时('\0')才结束转换，并将结果返回。如果 nptr不能转换成 int 或者 nptr为空字符串，那么将返回 0。

题目说明包含所有输入情况，需要考虑：

- 开头过滤空白字符
    + isspace( )函数
- 符号位
- 顺序 ${(blank character)}^{\*}  {(+|-)}^{\*} {(num)}^{\*}$
- 溢出
- 无效输入
    + 连着2个符号位及以上
    + "+ 123"


奇葩输入：

- "     001"
- "18446744073709551617"


# 解决

可改进：

- 过滤符号位麻烦，类似'+-'情况直接放最后考虑。
- 判断溢出
- 最终处理符号位 \*

```cpp
    int myAtoi(string str) {
        int num = 0;
        int flag = 0;           //记录符号位
        int i,start;
        bool overflow = false;  //溢出标志

        for (i = 0; isspace(str[i]); i++) {}    //过滤空白符
        start = i;  //
        for (; i < str.length(); i++) { //过滤'+'、'-'
            if (str[i] == '+') flag++;
            else if (str[i] == '-') flag--;
            else
                break;
        }
        for (; i < str.length(); i++) {
            if (str[i] >= '0' && str[i] <= '9') {
                //num = num * 10 + str[i] - 48;

                int tmp = num * 10;
                if (tmp / 10 != num)    //乘法溢出
                    overflow = true;

                num = tmp + str[i] - 48;
                if (overflow == false && num < 0)
                    overflow = true;    //加法溢出
                        
                if (i == start) flag = 1;   //没有'+'、'-'符号出现
            }
            else
                break;
        }

        switch (flag)
        {
        case 1: 
            if (overflow) return INT_MAX;
            else return num;
        case -1:
            if (overflow) return INT_MIN;
            else return -1 * num;
        default:
            return 0;
        }
    }
```

# 参考

- 用`i++`连接三个过程
- 对溢出的判断
    + `INT_MIN` -2147483648 被误判为overflow，但结果恰好正确。

```cpp
int atoi(const char *str) {
    int sign = 1, base = 0, i = 0;
    while (str[i] == ' ') { i++; }
    if (str[i] == '-' || str[i] == '+') {
        sign = 1 - 2 * (str[i++] == '-');       //先赋值再++
    }
    while (str[i] >= '0' && str[i] <= '9') {
        //判断溢出
        if (base >  INT_MAX / 10 || (base == INT_MAX / 10 && str[i] - '0' > INT_MAX % 10)) {
            if (sign == 1) return INT_MAX;
            else return INT_MIN;
        }
        base  = 10 * base + (str[i++] - '0');
    }
    return base * sign;
}
```

# something

- INT_MAX等范围值在`<limits.h>`文件中。
- [判断溢出](/2017/08/04/C-如何判断整型运算溢出/)



