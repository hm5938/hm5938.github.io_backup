---
layout: post
title:  "[알고리즘]   정수 제곱근 판별"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12934
comments: false
---
### **문제 설명**

임의의 양의 정수 n에 대해, n이 어떤 양의 정수 x의 제곱인지 아닌지 판단하려 합니다.n이 양의 정수 x의 제곱이라면 x+1의 제곱을 리턴하고, n이 양의 정수 x의 제곱이 아니라면 -1을 리턴하는 함수를 완성하세요.

### 제한 사항

- n은 1이상, 50000000000000 이하인 양의 정수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/62d19c62d45147d1bb2f84dda21e25a6)

### 입출력 예 설명

**입출력 예#1**121은 양의 정수 11의 제곱이므로, (11+1)를 제곱한 144를 리턴합니다.

**입출력 예#2**3은 양의 정수의 제곱이 아니므로, -1을 리턴합니다.

### 나의 풀이

1. 어떤 수 의 제곱인지 아닌지 판단하기 위해 n의 제곱근을 1로 나누어 떨어지는지 판단
2. 나누어 떨어진다면 n+1의 제곱 리턴
3. 아니라면 -1 리턴

```python
import math
def solution(n):
    answer = math.sqrt(n)
    if (math.sqrt(n) % 1) == 0:
        return math.pow(int(answer)+1, 2)
    else:
        return -1
```

```java
class Solution {
        public long solution(long n) {
            if((Math.sqrt(n)%1)==0){
                return (long) Math.pow((int)Math.sqrt(n)+1,2);
            }else{
                return -1;
            }
        }
    }
```