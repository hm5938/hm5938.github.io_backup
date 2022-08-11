---
layout: post
title:  "[알고리즘]   자릿수 더하기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12931
comments: false
---
### **문제 설명**

자연수 N이 주어지면, N의 각 자릿수의 합을 구해서 return 하는 solution 함수를 만들어 주세요.예를들어 N = 123이면 1 + 2 + 3 = 6을 return 하면 됩니다.

### 제한사항

- N의 범위 : 100,000,000 이하의 자연수

---

### 입출력 예

[제목 없음](https://www.notion.so/645419d12aab46a9b91efe3164ab5da5)

### 입출력 예 설명

입출력 예 #1문제의 예시와 같습니다.

입출력 예 #29 + 8 + 7 = 24이므로 24를 return 하면 됩니다.

### 나의 풀이

1. n의 자리수 만큼 반복해준다
2. 한 번 반복할 때 마다 n을 10으로 나눈 나머지를 더해주고 n 은 10으로 나눈다.

```python
def solution(n):
    answer = 0
    num_str = str(n)

    for s in num_str:
        answer += int(s)

    return answer
```

```java
public class Solution {
    public int solution(int n) {
        int answer = 0;

        while(n>0){
            answer+=n%10; //10으로 나눈 나머지를 더해 준다
            n=n/10; n //10으로 나눈 값을 n에 넣어준다
        }

        return answer;
    }
}
```

tip. log10을 이용해서도 자릿수를 구할수있다.