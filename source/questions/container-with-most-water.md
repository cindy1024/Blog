---
title: Container With Most Water
date: 2017-11-09 15:13:18
toc: true
---
装最多水的容器。<!--more-->

# 题目 11 

Given n non-negative integers a1, a2, ..., an, where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.

**Note:** You may not slant the container and n is at least 2.

给定 n 个非负整数 a1, a2, ..., an, 每个数代表了坐标中的一个点 (i, ai)。画 n 条垂直线，使得 i 垂直线的两个端点分别为(i, ai)和(i, 0)。找到两条线，使得其与 x 轴共同构成一个容器，以容纳最多水。

# 分析

一开始看到题目有些发懵，反复读了几遍，其实就是 **木桶效应+最大长方形** 问题的结合。两条直线中，较短的一条成为短板。用两个指针分别从左右开始往中间走，希望继续寻找比短板更高的直线。过程比较简单。

# 解决


```cpp
    int maxArea(vector<int>& height) {
        int maxArea = 0;
        int area = 0;
        int i = 0;
        int j = height.size() - 1;
        while (i < j) {
            if (height[i] <= height[j]) {
                area = (j - i)*height[i];   //计算面积
                i++;                        //左边指针往中间走
            }
            else {
                area = (j - i)* height[j];  //计算面积
                j--;                        //右边指针往中间走
            }
            if (area > maxArea) maxArea = area;
        }
        return maxArea;
    }
```


