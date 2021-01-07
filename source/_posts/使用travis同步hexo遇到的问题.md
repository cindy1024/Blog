---
title: 使用travis同步hexo时报错
date: 2021-01-07 09:07:08
tags: 
- github
- 博客
catagories: 博客
mathjax: true
---
<!-- more -->

# travis 报错

1. **The command "npm" failed and exited with 1 during .**

    **解决：**

    将`.travis.yml`由

    ```yml
    install:   
    	- npm
    ```

    改为

    ```yml
    install:   
    	- npm install
    ```



2. **The command "npm test" exited with 1.**

   **具体：**

   ```
npm ERR! missing script: test
   npm ERR! A complete log of this run can be found in:
npm ERR!     /home/travis/.npm/_logs/2021-01-07T02_16_47_056Z-debug.log
   ```
   
   **原因：**node8/stable安装node-sass低版本有bug[1]
   

    **解决：**

    将`.travis.yml`由

   ```yml
   node_js: 
   	- stable
   ```
   
   
    改为
       
    ```yml
   node_js: 
   	- 6
    ```
   



3. **The command "hexo clean" exited with 126.**

   **具体：**

   ```
   /home/travis/.travis/functions: line 109: ./node_modules/.bin/hexo: Permission denied
   ```
   
   **解决：**
   
   `.travis.yml`中增加
   
   ```yml
   before_install:
     - chmod +x ./node_modules/.bin/hexo
   ```
   



4. **ERROR Plugin load failed: hexo-server**

   **解决：**

   `.travis.yml`中增加

   ```yml
   before_install:
     - npm install hexo-cli -g
     - npm install hexo-server --save
   ```

   

5. **travis成功后网页全是空白，gh-pages内容为空**

   **原因：**theme/next主题下含有.git文件夹

   **解决：**参照[2]，并把node改为v10版本。

   

# .travis.yml

```yml
language: node_js 
node_js: 
  - 10
cache:   
  apt: true
  directories:   
    - node_modules # 要缓存的文件夹


before_install:
  - export TZ='Asia/Shanghai' # 更改时区
  - npm install hexo-cli -g
  - npm install hexo-server --save
  - chmod +x ./node_modules/.bin/hexo

install:   
  - npm install
script:   
  - hexo clean   
  - hexo g 
after_script:   # 最后执行的命令   
  - cd ./public   
  - git init   
  - git config user.name "your_name"  
  - git config user.email "your_email"   
  - git add .    
  - git commit -m "Travis CI Auto Builder at $(date +'%Y-%m-%d %H:%M:%S')"   
  - git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages 
  - git push --force --quiet "https://${CD_USER_TOKEN}:${CD_TOKEN}@${CD_REF}" master:gh-pages
branches:   
  only:
    - master # 触发持续集成的分支 
env:  
  global:    
    - GH_REF: github.com/user/repo.git 
    - CD_REF: e.coding.net/user/repo/repo.git
    - CD_USER_TOKEN: xxxxxx
```

**作用：**本地使用命令`hexo clean&&hexo d`生成并部署。hexo的`_config.yml`采用如下配置，每次部署自动将源代码推送到github和coding中repo的master分支。master分支代码的改动，触发travis过程，将静态文件推送到github和coding中repo的gh-pages分支，用于展示网站。

```yml
deploy:
- type: git
  repo: git@github.com:user/repo.git
  branch: master
- type: git
  repo: git@e.coding.net:user/repo/repo.git
  branch: master
```




# 参考

[1] [Travis CI部署hexo博客，npm install失败](https://segmentfault.com/q/1010000011317783)

[2] [changes not staged for commit 错误的解决方法](https://yxyuxuan.github.io/2019/07/16/changes-not-staged-for-commit%E9%94%99%E8%AF%AF%E7%9A%84%E8%A7%A3%E5%86%B3%E6%96%B9%E6%B3%95/)