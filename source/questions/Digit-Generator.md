title: Digit Generator
date: 2017-08-17 15:53:17
toc: true
---
生成元。<!--more-->

# [题目 1583](https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=4458)

如果x加上x的各个数字之和等于y，就说x是y的生成元。245是256 (= 245 + 2 + 4 + 5)的生成元。 

有的数字没有生成元，有的数字不止一个（找到最小的）。

### Input

Your program is to read from standard input. The input consists of T test cases. The number of test cases T is given in the first line of the input. Each test case takes one line containing an integer N, 1 ≤ N ≤ 100, 000.

### Output

Your program is to write to standard output. Print exactly one line for each test case. The line is to contain a generator of N for each test case. If N has multiple generators, print the smallest. If N does not have any generators, print ‘0’.

### Sample Input

```
3
216
121
2005
```

### Sample Output

```
198
0
1979
```

# 分析

遍历N-1个数效率低，利用 **y - x数字之和 = x** ，对于y，判断 (y - sum)的数字之和与sum是否相等。首先要求y的位数n，sum的最大可能为 n * 9（x由n个9组成）。

# 解决

```cpp
#include <iostream>
using namespace std;

int getDigit(int x) {
    int nDigit = 1;
    while (x) {
        x /= 10;
        nDigit++;
    }
    return nDigit;
}

int getSumDigit(int x) {
    int sum = 0;
    while (x) {
        int tmp = x % 10;
        sum += tmp;
        x /= 10;
    }
    return sum;
}


int main() {
    int c;
    while (cin >> c) {
        int x;
        for (int k = 0;cin >> x &&  k < c; k++) {
            int n = getDigit(x);
            int res = 0;
            
            for (int i = 9 * n; i >= 0; i--) {
                if (i == getSumDigit(x - i) ) {
                    res = x - i;
                    break;
                }
            }
            cout << res << endl;
        }
    }
    return 0;
}

```

# 参考

刘汝佳的做法：枚举100000内所有正整数x，计算y，生成表。要用时查表

# 其他

### [快速取得一个整数的最高位](https://stackoverflow.com/questions/701322/how-can-you-get-the-first-digit-in-an-int-c/701621#701621)

查资料过程看到，只有一点相关，但要记录每一位的情况下还是老办法好。

最佳：**Unrolled & optimized loop**

```c
if (i >= 100000000) i /= 100000000;
if (i >= 10000) i /= 10000;
if (i >= 100) i /= 100;
if (i >= 10) i /= 10;
```
