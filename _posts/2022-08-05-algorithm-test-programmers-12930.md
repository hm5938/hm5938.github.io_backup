---
layout: post
title:  "[알고리즘]   이상한 문자 만들기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12930
comments: false
---
### **문제 설명**

문자열 s는 한 개 이상의 단어로 구성되어 있습니다. 각 단어는 하나 이상의 공백문자로 구분되어 있습니다. 각 단어의 짝수번째 알파벳은 대문자로, 홀수번째 알파벳은 소문자로 바꾼 문자열을 리턴하는 함수, solution을 완성하세요.

### 제한 사항

- 문자열 전체의 짝/홀수 인덱스가 아니라, 단어(공백을 기준)별로 짝/홀수 인덱스를 판단해야합니다.
- 첫 번째 글자는 0번째 인덱스로 보아 짝수번째 알파벳으로 처리해야 합니다.

### 입출력 예

[제목 없음](https://www.notion.so/e5a60674a04c4f55a4b7d1b0ceca0140)

### 입출력 예 설명

"try hello world"는 세 단어 "try", "hello", "world"로 구성되어 있습니다. 각 단어의 짝수번째 문자를 대문자로, 홀수번째 문자를 소문자로 바꾸면 "TrY", "HeLlO", "WoRlD"입니다. 따라서 "TrY HeLlO WoRlD" 를 리턴합니다.

### 나의 풀이

1. 문자열만큼 반복한다.
2. index를 늘려 짝수이면 대문자 홀수이면 소문자로 바꿔준다.
3. 공백을 만나면 index를 초기화해준다.

```python
def solution(s):
    str_list = list(s)
    index = 0
    for i in range(0, len(str_list)):
        char = str_list[i]
        if ord(char) == 32:
            index = 0
        else:
            if index % 2 == 0:
                str_list[i] = str_list[i].upper()
            else:
                str_list[i] = str_list[i].lower()
            index += 1

    answer ="".join(str_list)
    return answer
```

```java
class Solution {
        String solution(String s) {
            StringBuilder sb = new StringBuilder(s);
            int index=0;
            for(int i=0;i<sb.length();i++){
                if(sb.charAt(i)==32) index=0;
                else{
                    if(index%2==0){
                            sb.setCharAt(i, Character.toUpperCase(sb.charAt(i)));
                        }else{
                            sb.setCharAt(i,Character.toLowerCase(sb.charAt(i)));
                        }
                    index++;
                }
            }
            return sb.toString();
        }
}
```