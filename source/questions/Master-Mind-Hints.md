title: Master-Mind Hints
date: 2017-08-15 21:25:44
toc: true
---

猜数字游戏的提示。<!--more-->

# [题目 340](https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=276) 

猜数字游戏，给定用户序列`a secret code`和答案序列`guesses`，统计有多少数字位置正确（A）`a strong match`，多少数字在两个序列都出现过但位置不对（B）`a weak match`。

输入第一行为序列长度n，第二行为答案序列，接下来是猜测序列。猜测序列为全零，该组数据结束；n=0时输入结束。（数字1~9）

s[i]==p[j] 且 i==j 时, a strong match
s[i]==p[j] 且 i!=j 时, a weak match

### Sample Input

![mark](http://cindy1024-blog.test.upcdn.net/20170816/172153549.png)

### Sample Output

注意输入格式，序列前面有4个空格 orz...

![mark](http://cindy1024-blog.test.upcdn.net/20170816/172219874.png)

# 分析

起初思维被限定，按照count流程一个个计算，要考虑很多情况，非常麻烦。

参考刘汝佳思路：直接统计可得A。为了求B，对每个数字，统计在二者出现的次数c1和c2，min(c1, c2)是该数字对B的贡献。最后的最后减去A的部分。

用数组a、b分别统计每个数字在两序列出现次数。

# 解决

```cpp
#include <string.h>
#include <iostream>
using namespace std;
int main() {
    int n;
    int game = 0;
    int a[10] = { 0 };
    
    while (cin >> n) {
        if (n == 0) break;
        int *num = new int[n];

        for (int i = 0; i < n; i++) {
            int x;
            cin >> x;
            num[i] = x;
            a[x]++;
        }
        cout << "Game " << ++game << ":" << endl;

        while (1) {
            int b[10] = { 0 };
            int zero,correct, dislocate;    //输入0的个数、A个数、B个数
            zero = correct = dislocate = 0;
            
            for (int i = 0; i < n; i++) {
                int x;
                cin >> x;
                b[x]++;
                if (x == 0) zero++;
                if (x == num[i]) correct++;
            }

            if (zero == n) break;
            for (int i = 1; i < 10; i++) {
                dislocate += a[i] <= b[i] ? a[i] : b[i];
                
            }
            dislocate -= correct;
            cout << '(' << correct << ',' << dislocate << ')' << endl;
        }
        memset(a, 0, sizeof(a));
        delete[] num;

    }
    return 0;
}
```