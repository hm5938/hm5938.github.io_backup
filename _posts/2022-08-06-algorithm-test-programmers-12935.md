---
layout: post
title:  "[알고리즘]   제일 작은 수 제거하기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12935
comments: false
---
### **문제 설명**

정수를 저장한 배열, arr 에서 가장 작은 수를 제거한 배열을 리턴하는 함수, solution을 완성해주세요. 단, 리턴하려는 배열이 빈 배열인 경우엔 배열에 -1을 채워 리턴하세요. 예를들어 arr이 [4,3,2,1]인 경우는 [4,3,2]를 리턴 하고, [10]면 [-1]을 리턴 합니다.

### 제한 조건

- arr은 길이 1 이상인 배열입니다.
- 인덱스 i, j에 대해 i ≠ j이면 arr[i] ≠ arr[j] 입니다.

### 입출력 예

[제목 없음](https://www.notion.so/ac4e3310a5cb4adcb0f612968258259b)

### 나의 풀이

1. 배열의 길이가 1이라면 -1리턴
2. 배열을 복사해 정렬한 후 제일 첫번째 값을 원래 배열에서 지운다.

```python
def solution(arr):
    if len(arr) ==1:
        return [-1]
    else:
        sorted_list = sorted(arr)
        arr.remove(sorted_list[0])
        
    answer = arr
    return answer
```

```java
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;
 class Solution {
        public int[] solution(int[] arr) {
            if(arr.length==1) return new int[]{-1};
            ArrayList<Integer> arrayList = (ArrayList<Integer>) Arrays.stream(arr).boxed().collect(Collectors.toList());

            int[] sort_list = Arrays.copyOf(arr ,arr.length);
            Arrays.sort(sort_list);
            arrayList.remove((Integer)sort_list[0]);

            int[] answer =arrayList.stream()
                    .mapToInt(Integer::intValue)
                    .toArray();
            return answer;
        }
    }
```