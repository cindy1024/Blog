---
title: Reverse Integer
date: 2017-08-03 12:31:08
mathjax: true
toc: true
---
翻转32位有符号整型数字，注意溢出。<!--more-->

# 题目 7

Reverse digits of an integer.

Example1: x = 123, return 321
Example2: x = -123, return -321

**Note:** The input is assumed to be a 32-bit signed integer. Your function should return 0 when the reversed integer overflows.

# 分析

- 32位有符号整型范围：$[-2^{31} , 2^{31}-1]$
- 溢出 `int y = a*b;` 在得出a*b的结果时已经溢出（在赋值之前）

# 解决

```cpp
int reverse(int x) {
    const int max = pow(2, 31) - 1;
    if (x > max || x < -max - 1) return 0;
    double y = 0;
    while( x != 0)
    {
        double tmp = y * 10 + (x % 10);
        y = (tmp > max || tmp < -max - 1) ? 0:tmp;  //判断溢出
        x /= 10;
    }
    return (int)y;
}
```

# 参考

主体过程一样，区别在于**对溢出的处理**：
- 用long保存中间转换数
- long赋值给int，若赋值后两边不等，溢出。

```cpp
class Solution {
public:
    int reverse(int x) {
        long long numReversed = 0;      //长整型64位
        int num = x;
        while ( num != 0 ) {
            numReversed = numReversed * 10 + num % 10;
            num /= 10;
        }
        int y = numReversed;
        if (y == numReversed) return y;
        else return 0;
    }
};
```

# something

#### 数的表示

- 科学计数法 `2E31` => $2* (10^{31})$
- 次方的表示 `pow(2,31)` => $2^{31}$  （注：头文件`<math.h>`）

#### [如何判断溢出](/2017/08/04/C-如何判断整型运算溢出/)

