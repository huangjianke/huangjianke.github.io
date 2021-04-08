---
title: LeetCode 刷题笔记
date: 2021-04-08 12:00:00 +0800
tags: [Swift, LeetCode, 算法, 数据结构]
categories: [代码人生, LeetCode]
pin: true
---

[LeetCode](https://leetcode-cn.com) 刷题笔记，持续更新ing...

<!-- more -->

| 序号 | 标题 | 难度 | 时间复杂度 | 空间复杂度 | 题解 |
|:---:|:---|:---:|:---:|:---:|:---:|
| 1 | [两数之和](https://leetcode-cn.com/problems/two-sum/) | 简单  | O(n) | O(n) | [Swift](#0001) |
| 26 | [删除有序数组中的重复项](https://leetcode.com/problems/remove-duplicates-from-sorted-array) | 简单  | O(n) | O(1) | [Swift](#0026) |

<a name="0001" />

## 两数之和

```swift
/**
 * 主要思路: 
 * 遍历数组，并且使用 map 存储 target - nums[i] 的值
 * 
 * 时间复杂度: O(n), 空间复杂度: O(n)
 */
class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        for (i, num) in nums.enumerated() {
            if let lastIndex = dict[target - num] {
                return [lastIndex, i]
            }
            dict[num] = i
        }
        fatalError("No valid outputs")
    }
```

<a name="0026" />

## 删除有序数组中的重复项

```swift
/**
 * 主要思路: 
 * 定义一个索引index, 遍历数组过程中与该索引的值进行对比，如果不一致，则修改对应索引的值
 * 
 * 时间复杂度: O(n), 空间复杂度: O(1)
 */
class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
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