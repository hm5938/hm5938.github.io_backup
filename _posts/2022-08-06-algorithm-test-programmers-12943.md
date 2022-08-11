---
layout: post
title:  "[알고리즘]   콜라츠 추측"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12943
comments: false
---
### **문제 설명**

1937년 Collatz란 사람에 의해 제기된 이 추측은, 주어진 수가 1이 될 때까지 다음 작업을 반복하면, 모든 수를 1로 만들 수 있다는 추측입니다. 작업은 다음과 같습니다.

`1-1. 입력된 수가 짝수라면 2로 나눕니다. 
1-2. 입력된 수가 홀수라면 3을 곱하고 1을 더합니다. 
2. 결과로 나온 수에 같은 작업을 1이 될 때까지 반복합니다.`

예를 들어, 주어진 수가 6이라면 6 → 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1 이 되어 총 8번 만에 1이 됩니다. 위 작업을 몇 번이나 반복해야 하는지 반환하는 함수, solution을 완성해 주세요. 단, 주어진 수가 1인 경우에는 0을, 작업을 500번 반복할 때까지 1이 되지 않는다면 –1을 반환해 주세요.

### 제한 사항

- 입력된 수, `num`은 1 이상 8,000,000 미만인 정수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/2c5e6dff439145a1925b74c0cd594cbb)

### 입출력 예 설명

입출력 예 #1문제의 설명과 같습니다.

입출력 예 #216 → 8 → 4 → 2 → 1 이 되어 총 4번 만에 1이 됩니다.

입출력 예 #3626331은 500번을 시도해도 1이 되지 못하므로 -1을 리턴해야 합니다.

---

※ 공지 - 2022년 6월 10일 다음과 같이 지문이 일부 수정되었습니다.

- 주어진 수가 1인 경우에 대한 조건 추가

### 나의 풀이

1. num이 1이라면 0 리턴
2. num이 짝수이면 2로 나눔, 홀수 이면 3을 곱하고 1을 더함
3. answer 에 1을 더해줌
4. num이 1이 될 때 까지 2,3 반복

```python
def solution(num):
    answer = 0
    if num == 1:
        return 0

    while num != 1:
        if answer >= 500:
            return -1
        if num % 2 == 0:
            num = num / 2
        else:
            num = num * 3 + 1
        answer += 1

    return answer
```

```java
class Solution {
        public int solution(long num) {
            
            int answer = 0;
            
            if (num == 1) return 0;

            while (num != 1) {
                answer++;
                
                if (answer >= 500) return -1;
                
                if (num%2==0) {
                    num /=2;
                } else {
                    num = num*3+1;
                }

                
            }
            return answer;
        }
    }
```