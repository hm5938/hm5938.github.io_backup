---
layout: post
title:  "[알고리즘]   하샤드 수"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12947
comments: false
---
### **문제 설명**

양의 정수 x가 하샤드 수이려면 x의 자릿수의 합으로 x가 나누어져야 합니다. 예를 들어 18의 자릿수 합은 1+8=9이고, 18은 9로 나누어 떨어지므로 18은 하샤드 수입니다. 자연수 x를 입력받아 x가 하샤드 수인지 아닌지 검사하는 함수, solution을 완성해주세요.

### 제한 조건

- `x`는 1 이상, 10000 이하인 정수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/c425ffb2501144c781122be885595b7a)

### 입출력 예 설명

**입출력 예 #1**10의 모든 자릿수의 합은 1입니다. 10은 1로 나누어 떨어지므로 10은 하샤드 수입니다.

**입출력 예 #2**12의 모든 자릿수의 합은 3입니다. 12는 3으로 나누어 떨어지므로 12는 하샤드 수입니다.

**입출력 예 #3**11의 모든 자릿수의 합은 2입니다. 11은 2로 나누어 떨어지지 않으므로 11는 하샤드 수가 아닙니다.

**입출력 예 #4**13의 모든 자릿수의 합은 4입니다. 13은 4로 나누어 떨어지지 않으므로 13은 하샤드 수가 아닙니다.

### 나의 풀이

1. n을 10으로 나눈 나머지를 모두 더해 각 자릿수의 합을 구한다.
2. 나온 값을 10으로 나눈 나머지 값을 리턴한다.

```java
class Solution {
    public boolean solution(int x) {
        boolean answer = true;
        answer = (x%getSum(x)==0);
        return answer;
    }
    
    public int getSum(int n){
        int answer = 0;

        while(n>0){
            answer+=n%10;
            n=n/10;
        }

        return answer;
    }
}
```