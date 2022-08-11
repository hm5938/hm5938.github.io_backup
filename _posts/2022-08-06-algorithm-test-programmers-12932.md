---
layout: post
title:  "[알고리즘]   자연수 뒤집어 배열로 만들기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12932
comments: false
---
### **문제 설명**

자연수 n을 뒤집어 각 자리 숫자를 원소로 가지는 배열 형태로 리턴해주세요. 예를들어 n이 12345이면 [5,4,3,2,1]을 리턴합니다.

### 제한 조건

- n은 10,000,000,000이하인 자연수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/6ce40e0b46f3469da7766744dd2183a3)

### 나의 풀이

1. string으로 변환하여 뒤집은 후 정수로 다시 변환해준다.

```python
def solution(n):

    list_str = list(str(n))
    list_str.reverse()
    answer = list(map(int, list_str))

    return answer
```

### 나의 풀이 2

1. 10으로 나눈 나머지를 구하면 뒤에서부터 자릿수를 구할 수 있다.

```java
class Solution {
    public int[] solution(long n) {
        int[] answer = new int[Long.toString(n).length()];
        int i = 0;
           while(n>0){
            answer[i++] = (int)(n%10);
            n=n/10;
        }
        return answer;
    }
}
```