---
layout: post
title:  "[알고리즘]   약수의 개수와 덧셈"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 77884
comments: false
---
### **문제 설명**

두 정수 `left`와 `right`가 매개변수로 주어집니다. `left`부터 `right`까지의 모든 수들 중에서, 약수의 개수가 짝수인 수는 더하고, 약수의 개수가 홀수인 수는 뺀 수를 return 하도록 solution 함수를 완성해주세요.

---

### 제한사항

- 1 ≤ `left` ≤ `right` ≤ 1,000

---

### 입출력 예

[제목 없음](https://www.notion.so/38389a718e6e4bfb9a976f8608890707)

---

### 입출력 예 설명

**입출력 예 #1**

- 다음 표는 13부터 17까지의 수들의 약수를 모두 나타낸 것입니다.

[제목 없음](https://www.notion.so/4960fa8f7c96496d8295fbe5566e3104)

- 따라서, 13 + 14 + 15 - 16 + 17 = 43을 return 해야 합니다.

**입출력 예 #2**

- 다음 표는 24부터 27까지의 수들의 약수를 모두 나타낸 것입니다.

[제목 없음](https://www.notion.so/4bb2e656044745ee875508eec60786a7)

- 따라서, 24 - 25 + 26 + 27 = 52를 return 해야 합니다.

### 나의 풀이

1. left 부터 right까지 의 수를 반복한다.
2. 1부터 n까지 나누어 떨어지는수 (n의 약수)를 구한다.
3. 짝수이면 +1 홀수이면 -1를 하여 리턴한다.

```java
class Solution {
        public int solution(int left, int right) {
            int answer = 0;
            for(int i = left;i<=right;i++){

                if(isMeasureNum(i)%2==0) answer+=i;
                else answer-=i;
            }
            return answer;
        }

        public int isMeasureNum(int n) {
            int result =0;
            for(int i=1;i<=n;i++){
                if(n%i==0) result++;
            }
            return result;
        }
    }
```