---
layout: post
title:  "[알고리즘] 2016년"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12901
comments: false
---
### **문제 설명**

2016년 1월 1일은 금요일입니다. 2016년 a월 b일은 무슨 요일일까요? 두 수 a ,b를 입력받아 2016년 a월 b일이 무슨 요일인지 리턴하는 함수, solution을 완성하세요. 요일의 이름은 일요일부터 토요일까지 각각 `SUN,MON,TUE,WED,THU,FRI,SAT`

입니다. 예를 들어 a=5, b=24라면 5월 24일은 화요일이므로 문자열 "TUE"를 반환하세요.

### 제한 조건

- 2016년은 윤년입니다.
- 2016년 a월 b일은 실제로 있는 날입니다. (13월 26일이나 2월 45일같은 날짜는 주어지지 않습니다)

### **입출력 예**

[제목 없음](https://www.notion.so/742f80662cfd43e0bd1cdef546fb4211)

### 나의 풀이

1. 달 별 날짜 수와 요일을 배열에 저장. 1일이 금요일이므로 0인 목요일부터 배열 초기화
2. 지나간 달의 날짜들과 일 수를 더해 며칠이 지나갔는지 계산 
3. 계산한 일 수를 7로 나눈 나머지 값으로 요일 계산

```python
def solution(a, b):
    months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    day = ["THU", "FRI", "SAT", "SUN", "MON", "TUE", "WED"]
    days = 0
    for i in range(0, a-1):
        days += months[i]
    days += b
    answer = day[days % 7]

    return answer
```

```java
class Solution {
        public String solution(int a, int b) {
            String answer = "";
            int[] months ={31,29,31,30,31,30,31,31,30,31,30,31};
            String[] day = {"THU","FRI","SAT","SUN","MON","TUE","WED"};
            int days =0;
            for(int i=0;i<a-1;i++){
                days += months[i];
            }
            days +=b;
            answer = day[days%7];
        
            return answer;
        }
}
```