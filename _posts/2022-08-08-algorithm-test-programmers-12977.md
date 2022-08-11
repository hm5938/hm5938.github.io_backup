---
layout: post
title:  "[알고리즘]   소수만들기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12977
comments: false
---
### **문제 설명**

주어진 숫자 중 3개의 수를 더했을 때 소수가 되는 경우의 개수를 구하려고 합니다. 숫자들이 들어있는 배열 nums가 매개변수로 주어질 때, nums에 있는 숫자들 중 서로 다른 3개를 골라 더했을 때 소수가 되는 경우의 개수를 return 하도록 solution 함수를 완성해주세요.

### 제한사항

- nums에 들어있는 숫자의 개수는 3개 이상 50개 이하입니다.
- nums의 각 원소는 1 이상 1,000 이하의 자연수이며, 중복된 숫자가 들어있지 않습니다.

---

### 입출력 예

[제목 없음](https://www.notion.so/bca83efde798433692e19f1d9a519e54)

### 입출력 예 설명

입출력 예 #1[1,2,4]를 이용해서 7을 만들 수 있습니다.

입출력 예 #2[1,2,4]를 이용해서 7을 만들 수 있습니다.[1,4,6]을 이용해서 11을 만들 수 있습니다.[2,4,7]을 이용해서 13을 만들 수 있습니다.[4,6,7]을 이용해서 17을 만들 수 있습니다.

### 나의 풀이

1. index는 그 수가 배열에 어디에 위치하는지를 나타낸다.
2. index1,2,3을 하나씩 증가시키면서 세 수의 합을 더해준다.
3. 더한 값들중 소수의 갯수를 찾는다.

```java
import java.util.ArrayList;
class Solution {
    public int solution(int[] nums) {
        int answer = 0;        
       ArrayList<Integer>  array = new ArrayList<>();
        int index1 = 0, index2 = 1, index3 = 2;
        while (index1 != nums.length - 2) {
            array.add(nums[index1] + nums[index2] + nums[index3]);
            if (nums.length - 1 != index3) {
                index3++;
            } else {
                if (nums.length - 2 != index2) {
                    index2++;
                    index3 = index2 + 1;
                } else {
                    index1++;
                    index2 = index1 + 1;
                    index3 = index2 + 1;
                }
            }
        }

        for (int sum : array) {
            if (isPrime(sum)) answer++;
        }

        return answer;
    }

    public boolean isPrime(int num) {
        for (int i = 2; i < num; i++) {
            if (num % i == 0) return false;
        }
        return true;
    }
    }
```