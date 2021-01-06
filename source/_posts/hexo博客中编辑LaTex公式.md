---
title: 博客常用
date: 2017-07-01 00:31:28
tags: [hexo, 博客]
categories: 博客
image: https://mir-s3-cdn-cf.behance.net/project_modules/1400/be159744794383.585e6bf22cc8f.jpg
---
集合多文，方便查看<!--more-->


# hexo命令

`hexo s`    启动服务器
`hexo g`    生成静态文件
`hexo d`    部署
`hexo new "文章名"`    新建文章
`hexo clean`    清除缓存文件和生成的静态文件

# markdown语法

### 编辑

> **粗体**
> 
> *斜体*
> 
> ~~删除~~
> 
> 分割线
> ***


### 标题

> \# 一级标题
> \## 二级标题
> ……
> \###### 六级标题

### 列表、表格

> * 无序
> * 列表
> 
> 1. 有序
> 2. 列表
> 
> 
> 
> | Tables （靠左）       | Are （居中）   | Cool （靠右） |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |


### 引用、代码

> 引用 
> 
>  `行内标记`
> 
>   ```
>   多行代码
>   ```


### 图片、链接

> ![不显图片text](url)
> 
> [text](url)


# LaTex 数学公式

### 脚本
``` html
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
```
### 公式

- 行内公式 `$y=x$`
- 整行公式 `$$y=x$$`

### 语法

- 上标 `x^2`  `x^{31}` （注：{}用于分组）
- 下标 `x_2`

### markdown与hexo自带的marked产生的语法冲突

手动加转义符\

|符号|markdown|hexo-render-marked|
|:---:|:---:|:---:|
|_|两个`\_`之间，表示<em>强调|下标|
|*|两个`\*`之间，表示斜体|乘号|

# 其他

### 与 sublime text 插件 Markdown Preview配合使用

自动间隔刷新，文章中插入如下：

```
<meta http-equiv="refresh" content="0.1">
```


# 参考
[hexo指令](https://hexo.io/zh-cn/docs/commands.html)
[Markdown——入门指南](http://www.jianshu.com/p/1e402922ee32/)
[Markdown进阶语法整理](http://www.jianshu.com/p/0b257de21eb5)
[Hexo下mathjax的转义问题](https://segmentfault.com/a/1190000007261752)







