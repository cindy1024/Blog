---
title: Pow(x, n)
date: 2020-05-11 
toc: true
---
<!--more-->

# 题目 50

实现 [pow(*x*, *n*)](https://www.cplusplus.com/reference/valarray/pow/) ，即计算 x 的 n 次幂函数。

**说明:**

- -100.0 < *x* < 100.0
- *n* 是 32 位有符号整数，其数值范围是$ [−2^{31}, 2^{31} − 1]$ 。

# 题解

## 二分法

这里有两个坑：

- 重复递归`computePow(x, n / 2)`，n较大时会超出时间限制。

```c++
double evenPow = computePow(x, n / 2) * computePow(x, n / 2);
if (n % 2 == 1) return  evenPow * x;
else return evenPow;
```

- `INT_MIN=-2147483648`  `-INT_MIN = INT_MAX + 1`

  在输入$x=1.00000, n=-2147483648$时`-n`会溢出，需要特殊处理。

## 妙蛙种子法（from评论区）

原理是：把底数变大，指数变小，res存储损失的值。

- for循环的次数即i作减半直到为1的次数，而`x *= x`相当于对幂作加倍，加倍的次数正好等于减半的次数。

- 但是由于i/2在i为奇数时会造成损失，损失量刚好是**上一次的x值**，需要把这个值乘到res里面做弥补。

- 同时**最后一次i/2必然为1**即奇数，所以最终得到的**x和损失量相乘**得到最终结果。

# 代码

## 二分法

```c++
    double myPow(double x, int n) {
        if (n == 0 || x == 1) return 1;
        //处理边界条件
        if (n == INT_MIN) return 1 / (computePow(x, INT_MAX) * x);
        if (n > 0) return computePow(x, n);
        else return 1 / computePow(x, -n);
    }

    double computePow(double x, int n) {
        if (n == 1) return x;
        //只递归一次
        double halfPow = computePow(x, n / 2);
        if (n % 2 == 1) return  halfPow * halfPow * x;
        else return halfPow * halfPow;
    }
```

避开边界条件也可以这样写：

```c++
    double myPow(double x, int n) {
        if (n == 0) return 1;
        double half = myPow(x, n / 2);
        if (n % 2 == 0) return half * half;
        if (n > 0) return half * half * x;
        return half * half / x;
    }
```

## 妙蛙种子法

```c++
    double myPow(double x, int n) {
        double res = 1.0;
        for (int i = n; i != 0; i /= 2) {
            if (i % 2 != 0) res *= x;
            x *= x;
        }
        return n < 0 ? 1 / res : res;
    }
```

