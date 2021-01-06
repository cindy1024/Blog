---
title: Palindrome Number
date: 2017-08-08 17:11:18
toc: true
---
判断回文数。<!--more-->

# 题目 9 
Determine whether an integer is a palindrome. Do this without extra space.

click to show spoilers.

***

**Some hints:**
Could negative integers be palindromes? (ie, -1)

If you are thinking of converting the integer to string, note the restriction of using extra space.

You could also try reversing an integer. However, if you have solved the problem "Reverse Integer", you know that the reversed integer might overflow. How would you handle such case?

There is a more generic way of solving this problem.

# 分析

负号不对称，负数不是回文数。

# 解决

用了额外的栈和队列空间。

```cpp
    bool isPalindrome(int x) {
        if (x < 0) return false;
        stack<int> s;
        queue<int> q;
        while (x != 0) {
            int tmp = x % 10;
            s.push(tmp);
            q.push(tmp);
            x /= 10;
        }
        while (s.size()) {
            if (s.top() == q.front()) {
                s.pop();
                q.pop();
            }
            else
                return false;
        }
        return true;
    }
```

# 参考

Only reversing till half and then compare. [007-Reverse-Integer](http://wuxinju.top/2017/08/03/Reverse-Integer/)

空间复杂度O(1)，与问题规模n无关。

```cpp
    bool isPalindrome(int x) {
        if(x<0|| (x!=0 &&x%10==0)) return false;    //10的倍数必定不是回文数
        int sum=0;
        while(x>sum)
        {
            sum = sum*10+x%10;
            x = x/10;
        }
        return (x==sum)||(x==sum/10);   //偶数位、奇数位
    }
```