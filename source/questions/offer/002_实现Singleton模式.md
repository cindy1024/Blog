---
title: 实现Singleton模式
date: 2020-10-09 12:17:00
toc: true
---
c#实现单例模式。<!--more-->

# 题目 002

设计一个类，只能生成该类的一个实例。

# 分析

要求只能生成一个实例，构造函数设为私有，其他类不能直接调用该类生成新的对象。“只能生成一个”，想到static的特性。

# 几种解法

- 方法一：判断静态成员变量是否为空，只适用于单线程。

- 方法二：在方法一的基础上，加同步锁再判断，可用于多线程。

- 方法三：修改方法二，加同步锁前后两次判断，减少加锁操作，提高效率。

- **方法四：**静态构造函数，可能会过早地创建实例。

  > 创建第一个类实例或任何静态成员被引用时，.NET将自动调用静态构造函数来初始化类。

  ```c#
  public sealed class Singleton4
  {
      private Singleton4(){}
      private static Singleton4 instance = new Singleton4();
      public static Singleton4 Instance
      {
          get
          {
              return instance;
          }
      }
  }
  ```

- **方法五：**按需创建，嵌套类+静态函数。

  - 父类的方法用static修饰，是为了绕过类的实例化来调用函数。【必须】
  - 子类的方法和变量用static修饰，是因为静态方法不能**直接**调用非静态成员。

  ```c#
public sealed class Singleton5
{
    Singleton5(){}
    public static Singleton5 Instance
    {
        get
        {
            return Nested.instance;
        }
    }

    class Nested
    {
        static Nested(){}
        internal static readonly Singleton5 instance = new Singleton5();
    }
}
  ```

	对方法五做如下修改，使得在Nested类中，不使用静态函数和变量（即方法五中子类不适用static），可达到相同效果：

  ```c#
public sealed class Singleton5
{
    Singleton5(){}
    public static Singleton5 Instance
    {
        get
        {
            Nested n = new Nested(); //modified
            return n.instance;		 //modified
        }
    }

    public class Nested
    {
        internal Nested(){} //modified
        internal readonly Singleton5 instance = new Singleton5(); //modified
    }
}
  ```

# 扩展

什么时候可以**不用实例化对象就可以调用类中成员函数**？

1. 类的静态成员函数。
2. 非静态成员函数没有使用类的非静态数据成员，调用的其他非静态成员函数也不能使用类的非静态数据成员。
3. 非静态成员函数调用类的静态数据成员。

（后面两种可以概括为【non-static的东西没有调用non-static的东西】）

来源：https://blog.csdn.net/dwb1015/article/details/32933349