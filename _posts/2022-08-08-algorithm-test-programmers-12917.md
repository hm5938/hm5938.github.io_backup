---
layout: post
title:  "[알고리즘]   문자열 내림차순으로 배치하기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12917
comments: false
---
### **문제 설명**

문자열 s에 나타나는 문자를 큰것부터 작은 순으로 정렬해 새로운 문자열을 리턴하는 함수, solution을 완성해주세요.s는 영문 대소문자로만 구성되어 있으며, 대문자는 소문자보다 작은 것으로 간주합니다.

### 제한 사항

- str은 길이 1 이상인 문자열입니다.

### 입출력 예

[제목 없음](https://www.notion.so/2e4e6e965b4149a3b837aeb6aad9f0aa)

### 나의 풀이

1. string을 char[]로 바꾸어 정렬한다.
2. stringbuilder을 이용해 순서를 바꿔준다.
3. string으로 바꾸어 리턴한다.

```java
import java.util.Arrays;   
class Solution {
        public String solution(String s) {
            String answer = "";
            char[] list = s.toCharArray();
            Arrays.sort(list);

            StringBuilder sb = new StringBuilder(String.valueOf(list));

            sb.reverse();
            answer = sb.toString();
            return answer;

        }
    }
```