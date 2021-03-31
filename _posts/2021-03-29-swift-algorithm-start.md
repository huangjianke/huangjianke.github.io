---
title: Swift算法&数据结构学习笔记 - 开篇
date: 2021-03-29 09:08:19
tags: [Swift, iOS, 算法, 数据结构]
categories: Swift
---

Hello, Swift!

该系列文章是记录自己在学习开源项目[Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club) 的一些笔记及心得。

## 1. 栈

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

## 2. 队列

队列的本质是一个列表，但只能从队尾添加元素，从队首移除元素。这保证了第一个入队的元素总是第一个出队。先到先得。

队列可以保证元素存入和取出的顺序是**先进先出(First-In, First-Out, FIFO)**的，第一个入队的元素总是第一个出队，公平合理。

### 2.1 简单实现

该只是简单地包装了一下自带的数组，并提供了**入队(enqueue)**、**出队(dequeue)**和**取得队首元素(peek)**三个操作。

```swift
public struct Queue<T> {
  fileprivate var array = [T]()

  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }

  public mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    if isEmpty {
      return nil
    } else {
      return array.removeFirst()
    }
  }
  
  public var front: T? {
    return array.first
  }
}
```

### 2.2 更加高效的队列

上面实现的队列只是可以正常工作，但并没有任何的优化。

入队操作的时间复杂度为 O(1)，因为在数组的尾部添加元素只需要固定的时间，跟数组的大小无关。因为在 `Swift` 的内部实现中，数组的尾部总是有一些预设的空间可供使用。如果我们进行如下操作：

```swift
var queue = Queue<String>()
queue.enqueue("Ada")
queue.enqueue("Steve")
queue.enqueue("Tim")
```

则数组可能看起来像下面这样：

```swift
[ "Ada", "Steve", "Tim", xxx, xxx, xxx ]
```

`xxx` 代表已经申请，但还没有使用的内存。在尾部添加一个新的元素就会用到下一块未被使用的内存：

为了让队列的出队操作更加高效，我们可以使用和入队所用的相同小技巧，保留一些额外的空间，只不过这次是在队首而不是队尾。这次我们需要手动编码实现这个想法，因为 `Swift` 内建数组并没有提供这种机制。

我们的想法如下：每当我们将一个元素出队，我们不再将剩下的元素向前移位（慢），而是将其标记为空（快）。在将 "Ada" 出队后，数组如下：

```swift
[ xxx, "Steve", "Tim", "Grace", xxx, xxx ]
```

这些在前端空出来的位子永远都不会再次使用，所以这是些被浪费的空间。解决方法是将剩下的元素往前移动来填补这些空位：

```swift
[ "Tim", "Grace", xxx, xxx, xxx, xxx ]
```

这就需要移动内存，所以这是一个**O(n)**操作，但因为这个操作只是偶尔发生，所以出队操作平均时间复杂度为**O(1)**。

下面给出了改进版的队列的时间方式：

```swift
public struct Queue<T> {
  fileprivate var array = [T?]()
  fileprivate var head = 0
  
  public var isEmpty: Bool {
    return count == 0
  }

  public var count: Int {
    return array.count - head
  }
  
  public mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    guard head < array.count, let element = array[head] else { return nil }

    array[head] = nil
    head += 1

    let percentage = Double(head)/Double(array.count)
    if array.count > 50 && percentage > 0.25 {
      array.removeFirst(head)
      head = 0
    }
    
    return element
  }
  
  public var front: T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}
```

现在数组存储的元素类型是`T?`，而不是先前的`T`，因为我们需要某种方式来将数组的元素标记为空。`head` 变量用于存储队列首元素的下标值。

绝大多数的改进都是针对`dequeue()`函数，在将队首元素出队时，我们首先将`array[head]`设置为`nil`来将这个元素从数组中移除。然后将`head`的值加一，使得下一个元素变成新的队首。

## 插入排序
## 二分搜索 & 二分搜索树
## 归并排序
## Boyer-Moore 字符串搜索