---
layout: post
title:  "[알고리즘]   수박수박수박수박수박수?"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12922
comments: false
---
### **문제 설명**

def solution(n):
words = ["수", "박"]
answer = ''
index = 0
for i in range(0, n):
answer += words[index]
if index == 1:
index = 0
else:
index += 1

```
return answer

```

길이가 n이고, "수박수박수박수...."와 같은 패턴을 유지하는 문자열을 리턴하는 함수, solution을 완성하세요. 예를들어 n이 4이면 "수박수박"을 리턴하고 3이라면 "수박수"를 리턴하면 됩니다.

### 제한 조건

- n은 길이 10,000이하인 자연수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/8f1ade4754eb456787164688c99cf40e)

### 나의 풀이

```python
def solution(n):
    words = ["수", "박"]
    answer = ''
    index = 0
    for i in range(0, n):
        answer += words[index]
        if index == 1:
            index = 0
        else:
            index += 1

    return answer
```

```java
class Solution {
        public String solution(int n) {
            String[] words = {"수","박"};
            String answer = "";

            int index =0;
            for(int i=0;i<n;i++){
                answer += words[index];
                if(index==1)index=0;
                else index++;
            }
            
            return answer;
        }
}
```