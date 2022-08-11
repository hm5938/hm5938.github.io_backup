---
layout: post
title:  "[알고리즘]   3진법 뒤집기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 68935
comments: false
---
### **문제 설명**

자연수 n이 매개변수로 주어집니다. n을 3진법 상에서 앞뒤로 뒤집은 후, 이를 다시 10진법으로 표현한 수를 return 하도록 solution 함수를 완성해주세요.

---

### 제한사항

- n은 1 이상 100,000,000 이하인 자연수입니다.

---

### 입출력 예

[제목 없음](https://www.notion.so/85c5e68f5aef402e961f52d19cf0752c)

---

### 입출력 예 설명

입출력 예 #1

- 답을 도출하는 과정은 다음과 같습니다.

[제목 없음](https://www.notion.so/0703b83ae3f44b669e118a71e8d305db)

- 따라서 7을 return 해야 합니다.

입출력 예 #2

- 답을 도출하는 과정은 다음과 같습니다.

[제목 없음](https://www.notion.so/a2d456d9ca1e4f1b94ab27cf7f8ccb4e)

- 따라서 229를 return 해야 합니다.

### 나의 풀이

1. 3을 나눈 나머지 값을 string에 추가해주므로 앞뒤를 뒤집은 3진법을 구해준다.
2. 나온 값을 10진법으로 바꿔준다.

```java
class Solution {
        public int solution(int n) {
            int answer = 0;
            String str = "";

            while(n>0){
                str += (n%3 + "");
                n = n/3;
            }

            int index=0;
            for(int i= str.length()-1;i>=0;i--){
                answer += Integer.parseInt(str.charAt(i)+"")*Math.pow(3,index);
                index++;
            }

            return answer;
        }
    }
```

TIP. `Integer.parseInt(temp, 3);` 을 사용하면 3진법을 10진법으로 바꿔준다.