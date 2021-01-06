---
title: C++如何判断整型运算溢出
date: 2017-08-04 16:27:08
tags: 
- C++ 
- 溢出
catagories: C++
mathjax: true
---
<!-- more -->

整数在计算机中主要由补码表示，分为无符号整数和有符号整数。若用i位表示整数，无符号整数的范围 $[0 , 2^i - 1]$ ，有符号整数的范围 $ [- 2 ^ {i-1} , 2^{i-1} - 1 ]$

>**阅读：**[整数在计算机中的表示](http://www.cnblogs.com/ccilery/p/6659928.html)

针对32位整型讨论

# 加法

## 无符号整型

溢出舍去一位，相当于$ a+b - 2^i$ ，有 a+b < a 或者 a+b < b 。

- 更长的临时变量保存

```cpp
int is_overflow_add_for_unsigned_int( unsigned int a, unsigned int b )
{
    long sum = a + b;
    return a + b < a || a + b < b;
}
```

- 另一种

```cpp
int is_overflow_add_for_unsigned_int( unsigned int a, unsigned int b )
{
  return UINT_MAX - a < b;
}

```

## 有符号整型

只有正溢出、负溢出两种情况。

```cpp
int is_overflow_add_for_signed_int( int a, int b )
{
  int sum = a + b;
  if (a > 0 && b > 0 && sum < 0) return 1;
  if (a < 0 && b < 0 && sum > 0) return 1;
  return 0;
}
```

```cpp
int is_overflow_add_for_signed_int( int a, int b )
{
  return a >= 0 ? INT_MAX - a < b : INT_MIN - a > b;
}
```

# 乘法

```cpp
int is_overflow_multiply_for_signed_int(int a,int b){
    int mul=a*b;
    return !a||mul/a==b;
}
```

```cpp
int is_overflow_multiply_for_unsigned_int( unsigned int a, unsigned int b )
{
  return a == 0 ? 0 : UINT_MAX / a < b;
}

int is_overflow_multiply_for_signed_int( int a, int b )
{
  return a == 0 ? 0 :
    a > 0 && b > 0 || a < 0 && b < 0 ? INT_MAX / a < b : INT_MIN / a > b;
}

```

# 赋值判断溢出

先用大一倍位长的临时变量保存，然后再看看截断后跟原值是不是一样。

```cpp
    long y = x * 10 + x % 10;
    int  res = y;
    if(res == y) return 0;
    else return 1;
```

# 参考
- [如何判断整型算术运算是否溢出](http://www.cnblogs.com/evilkant/p/6028074.html)
- [两个int变量相乘如何判断溢出？](http://bbs.chinaunix.net/thread-1031668-1-1.html)

