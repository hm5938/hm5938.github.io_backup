---
layout: post
title:  "[알고리즘]   약수의 합"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12928
comments: false
---
### **문제 설명**

정수 n을 입력받아 n의 약수를 모두 더한 값을 리턴하는 함수, solution을 완성해주세요.

### 제한 사항

- `n`은 0 이상 3000이하인 정수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/69322bbfb6fb4f47b18dedf8b1db3e48)

### 입출력 예 설명

입출력 예 #112의 약수는 1, 2, 3, 4, 6, 12입니다. 이를 모두 더하면 28입니다.

입출력 예 #25의 약수는 1, 5입니다. 이를 모두 더하면 6입니다.

### 나의 풀이

1. 1부터 n까지의 수로 나누어 떨어지면 약수라 판단 후 더해준다. 

```java
class Solution {
        public int solution(int n) {
            int answer = 0;
            for(int i=1;i<=n;i++){
                if(n%i==0) answer += i;
            }
            return answer;
        }
    }
```