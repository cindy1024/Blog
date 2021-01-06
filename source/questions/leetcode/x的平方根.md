---
title: x的平方根
date: 2020-05-10
toc: true
---
<!--more-->

# 题目 69

实现 `int sqrt(int x)` 函数。

计算并返回 x 的平方根，其中 x 是非负整数。

由于返回类型是整数，结果只保留整数的部分，小数部分将被舍去。

# 题解

## 二分法

有几个坑：

- `mid * mid <= x`的写法会导致溢出

  改成`min <= x/mid`

- 同理， `int mid = (left + right) / 2`也会导致溢出

  改成`int mid = (float)left / 2 + (float)right / 2`

## 牛顿法

# 代码

## 二分法

```c++
    int mySqrt(int x) {
        if (x == 0 || x == 1) return x;
        return findHalf(x, 1, x);
    }

    int findHalf(int x, int left, int right) {
        int mid = (float)left / 2 + (float)right / 2;
        if (mid <= x / mid && (mid + 1) > x / (mid + 1)) return mid;
        if (left < x / left && mid > x / mid) return findHalf(x, left, mid);
        else return findHalf(x, mid, right);
    }
```

## 牛顿法