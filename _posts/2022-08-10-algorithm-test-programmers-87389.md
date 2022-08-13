---
layout: post
title:  "[알고리즘]   나머지가 1이 되는 수 찾기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 87389
comments: false
---
### **문제 설명**

자연수 `n`이 매개변수로 주어집니다. `n`을 `x`로 나눈 나머지가 1이 되도록 하는 가장 작은 자연수 `x`를 return 하도록 solution 함수를 완성해주세요. 답이 항상 존재함은 증명될 수 있습니다.

---

### 제한사항

- 3 ≤ `n` ≤ 1,000,000

---

### 입출력 예

[제목 없음](https://www.notion.so/90797f060b664253b58cca920eaaf374)

---

### 입출력 예 설명

**입출력 예 #1**

- 10을 3으로 나눈 나머지가 1이고, 3보다 작은 자연수 중에서 문제의 조건을 만족하는 수가 없으므로, 3을 return 해야 합니다.

**입출력 예 #2**

- 12를 11로 나눈 나머지가 1이고, 11보다 작은 자연수 중에서 문제의 조건을 만족하는 수가 없으므로, 11을 return 해야 합니다.

### 나의 풀이

1. 1부터 n까지 1로 나누어 떨어지는 수가 있으면 그 수를 리턴한다
2. 없다면 n+1을 리턴한다

```java
class Solution {
        public int solution(int n) {
            for(int i=1;i<n+1;i++){
                if(n%i==1) return i;
            }
            return n+1;
        }
    }
```