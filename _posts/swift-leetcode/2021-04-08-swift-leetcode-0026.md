---
title: LeetCode 刷题笔记 - 删除有序数组中的重复项
date: 2021-04-08 12:00:00 +0800
tags: [Swift, LeetCode, 算法, 数据结构, 数组]
categories: [代码人生, LeetCode]
pin: true
---

## 题目链接

[删除有序数组中的重复项](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/)

## 算法实现

```swift
class Solution {
    func removeDuplicates(inout nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var index = 0
        for num in nums where num != nums[index] {
            index += 1
            nums[index] = num
        }
        return index + 1
    }
}
```

