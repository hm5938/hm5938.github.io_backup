---
layout: post
title:  "[알고리즘]   두 개를 뽑아서 더하기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 68644
comments: false
---
### **문제 설명**

정수 배열 numbers가 주어집니다. numbers에서 서로 다른 인덱스에 있는 두 개의 수를 뽑아 더해서 만들 수 있는 모든 수를 배열에 오름차순으로 담아 return 하도록 solution 함수를 완성해주세요.

---

### 제한사항

- numbers의 길이는 2 이상 100 이하입니다.
    - numbers의 모든 수는 0 이상 100 이하입니다.

---

### 입출력 예

[제목 없음](https://www.notion.so/f00908f12872411ba8007164a28b6b91)

---

### 입출력 예 설명

입출력 예 #1

- 2 = 1 + 1 입니다. (1이 numbers에 두 개 있습니다.)
- 3 = 2 + 1 입니다.
- 4 = 1 + 3 입니다.
- 5 = 1 + 4 = 2 + 3 입니다.
- 6 = 2 + 4 입니다.
- 7 = 3 + 4 입니다.
- 따라서 `[2,3,4,5,6,7]` 을 return 해야 합니다.

입출력 예 #2

- 2 = 0 + 2 입니다.
- 5 = 5 + 0 입니다.
- 7 = 0 + 7 = 5 + 2 입니다.
- 9 = 2 + 7 입니다.
- 12 = 5 + 7 입니다.
- 따라서 `[2,5,7,9,12]` 를 return 해야 합니다.

### 나의 풀이

1. index 두개를 만들어 배열의 끝까지 탐색할 때까지 하나씩더해준다.
2. index2가 배열 끝까지 가면 index1을 1 더해준다.
3. 탐색할 때마다 hashset에 두 수의 합을 추가한다.
4. hashset 을 int[]로 바꿔준다.
5. 정렬해준다.

```java
import java.util.Arrays;
import java.util.HashSet;
class Solution {
        public int[] solution(int[] numbers) {
            HashSet<Integer> hashSet = new HashSet<>();
            int index1 = 0, index2 = 1;
 
            while(!(index1==numbers.length-1&&index2==numbers.length)){
               hashSet.add(numbers[index1]+numbers[index2]);
               if(numbers.length-1!=index2)index2++;
               else {
                   index1++;
                   index2=index1+1;
               }
            }
            int[] answer = hashSet.stream()
                    .mapToInt(Integer::intValue)
                    .toArray();
            Arrays.sort(answer);
            return answer;
        }
}
```

TIP. TreeSet을 사용하면 중복없이 정렬도 한번에 할 수 있다.