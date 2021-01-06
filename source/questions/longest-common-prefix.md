---
title: Longest Common Prefix
date: 2017-11-21 21:16:44
toc: true
mathjax: true
---
最长共同前缀。<!--more-->

# 题目 14

Write a function to find the longest common prefix string amongst an array of strings.

# 分析

- 横向看 （先数组，再看列）
$LCP(S_{1}…S_{n})=LCP(LCP(LCP(S_{1},S_{2}),S_{3}),…S_{n})$
![](https://leetcode.com/media/original_images/14_basic.png)

- 纵向看（先看列，再数组）

# 解决

纵向

```cpp
string longestCommonPrefix(vector<string>& strs) {
    string str = "";
    if (strs.size() == 0) return str;
    for (int i = 0; i < strs[0].size(); i++) {  //每一列
        char ch = strs[0][i];
        bool flag = true;
        for (int j = 1; j < strs.size(); j++) { //数组（相当于行）
            if (ch != strs[j][i]) {
                flag = false;       //用标记记录进程，改进见参考
                break;
            }
        }
        if (flag) str += ch;
        else break;
    }
    return str;
}
```

# 参考

横向

```java
public String longestCommonPrefix(String[] strs) {
    if (strs.length == 0) return "";
    String prefix = strs[0];
    for (int i = 1; i < strs.length; i++)
        while (strs[i].indexOf(prefix) != 0) {
            prefix = prefix.substring(0, prefix.length() - 1);
            if (prefix.isEmpty()) return "";
        }        
    return prefix;
}
```

纵向

```java
public String longestCommonPrefix(String[] strs) {
    if (strs == null || strs.length == 0) return "";
    for (int i = 0; i < strs[0].length() ; i++){
        char c = strs[0].charAt(i);
        for (int j = 1; j < strs.length; j ++) {
            if (i == strs[j].length() || strs[j].charAt(i) != c)
                return strs[0].substring(0, i);        //flag改进成     
        }
    }
    return strs[0];
}
```

另一种想法：从长到短。先假设prefix为第一个串，依次比较其他串，改变prefix的位数。

```cpp
string longestCommonPrefix(vector<string>& strs) {
    if (strs.size() == 0)
    {
        return "";    
    }
    
    string prefix = strs[0];
    for (int i = 1; i < strs.size(); i++)
    {
        while (0 != strs[i].compare(0, prefix.length(), prefix))
        {
            prefix = prefix.substr(0, prefix.length()-1);
        }
    }
    
    return prefix;
}
```