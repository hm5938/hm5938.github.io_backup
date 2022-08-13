---
layout: post
title:  "[알고리즘]   시저 암호"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12926
comments: false
---
### **문제 설명**

어떤 문장의 각 알파벳을 일정한 거리만큼 밀어서 다른 알파벳으로 바꾸는 암호화 방식을 시저 암호라고 합니다. 예를 들어 "AB"는 1만큼 밀면 "BC"가 되고, 3만큼 밀면 "DE"가 됩니다. "z"는 1만큼 밀면 "a"가 됩니다. 문자열 s와 거리 n을 입력받아 s를 n만큼 민 암호문을 만드는 함수, solution을 완성해 보세요.

### 제한 조건

- 공백은 아무리 밀어도 공백입니다.
- s는 알파벳 소문자, 대문자, 공백으로만 이루어져 있습니다.
- s의 길이는 8000이하입니다.
- n은 1 이상, 25이하인 자연수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/a090effeccb84cc68d7e7df3b0c277d2)

### 나의 풀이

1. char[] 로 바꾸어  아스키코드 형태로 사용할 수 있게 한다.
2. 문자를 하나하나 n만큼 밀어준다.
3. 스트링으로 변환해서 리턴한다.

```java
class Solution {
        public String solution(String s, int n) {
            char[] chars =s.toCharArray();
            for(int i=0;i<chars.length;i++){
                char c = chars[i];
                if(c >= 65 && c <= 90) { //영어 대문자
                    chars[i]=  moveChar(c,n,65,90);

                }else if(c >=97 && c<=122){ //영어 소문자
                    chars[i]=  moveChar(c,n,97,122);
                }
                System.out.println(chars[i]);
            }
            return new String(chars);
        }
        
        public char moveChar(char c,int n,int range1,int range2){
            if(c+n >range2) return (char)(((c+n)-range1)%25+range1-1);
            else return (char)(c+n);
        }
    }
```