---
title: Swift算法&数据结构学习笔记 - 开篇
date: 2021-03-29 09:08:19
tags: [Swift, iOS, 算法, 数据结构]
categories: Swift
---

Hello, Swift!

该系列文章是记录自己在学习开源项目[Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club) 的一些笔记及心得。

## 栈

栈类似于数组，但相对于数组来说，栈有很多限制性。栈只允许我们从栈顶**压入(push)**元素；从栈**弹出(pop)**元素；在不弹出的情况下**取得(peek)**栈顶元素。

栈可以保证元素存入和取出的顺序是**后进先出(Last-In First-Out, LIFO)**的。栈中弹出的元素总是你最后放进去的那个。

队列则是**先进先出(First-In, First-Out, FIFO)**的结构。

需要注意的是，压栈操作是将新元素压入数组的尾部，而不是头部。在数组的头部插入元素是一个很耗时的操作，它的时间复杂度为**O(n)**，因为需要将现有元素往后移位为新元素腾出空间。而在尾部插入元素的时间复杂度为**O(1)**；无论数组有多少元素，这个操作所消耗的时间都是一个常量。

**栈(Stack)**的实现如下代码：
```swift
public struct Stack<T> {
  fileprivate var array = [T]()

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func push(_ element: T) {
    array.append(element)
  }

  public mutating func pop() -> T? {
    return array.popLast()
  }

  public var top: T? {
    return array.last
  }
}
```

## 队列
## 插入排序
## 二分搜索 & 二分搜索树
## 归并排序
## Boyer-Moore 字符串搜索