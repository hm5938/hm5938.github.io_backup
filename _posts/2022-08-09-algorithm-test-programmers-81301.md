---
layout: post
title:  "[알고리즘]   숫자 문자열과 영단어"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 81301
comments: false
---
### **문제 설명**

![https://grepp-programmers.s3.ap-northeast-2.amazonaws.com/files/production/d31cb063-4025-4412-8cbc-6ac6909cf93e/img1.png](https://grepp-programmers.s3.ap-northeast-2.amazonaws.com/files/production/d31cb063-4025-4412-8cbc-6ac6909cf93e/img1.png)

네오와 프로도가 숫자놀이를 하고 있습니다. 네오가 프로도에게 숫자를 건넬 때 일부 자릿수를 영단어로 바꾼 카드를 건네주면 프로도는 원래 숫자를 찾는 게임입니다.다음은 숫자의 일부 자릿수를 영단어로 바꾸는 예시입니다.

- 1478 → "one4seveneight"
- 234567 → "23four5six7"
- 10203 → "1zerotwozero3"

이렇게 숫자의 일부 자릿수가 영단어로 바뀌어졌거나, 혹은 바뀌지 않고 그대로인 문자열 `s`가 매개변수로 주어집니다. `s`가 의미하는 원래 숫자를 return 하도록 solution 함수를 완성해주세요.

참고로 각 숫자에 대응되는 영단어는 다음 표와 같습니다.

[제목 없음](https://www.notion.so/172a33ae4899442d874988b1621d6557)

---

### 제한사항

- 1 ≤ `s`의 길이 ≤ 50
- `s`가 "zero" 또는 "0"으로 시작하는 경우는 주어지지 않습니다.
- return 값이 1 이상 2,000,000,000 이하의 정수가 되는 올바른 입력만 `s`로 주어집니다.

---

### 입출력 예

[제목 없음](https://www.notion.so/ce053437d2c44941a3bb19f3dfa34768)

---

### 입출력 예 설명

**입출력 예 #1**

- 문제 예시와 같습니다.

**입출력 예 #2**

- 문제 예시와 같습니다.

**입출력 예 #3**

- "three"는 3, "six"는 6, "seven"은 7에 대응되기 때문에 정답은 입출력 예 #2와 같은 234567이 됩니다.
- 입출력 예 #2와 #3과 같이 같은 정답을 가리키는 문자열이 여러 가지가 나올 수 있습니다.

**입출력 예 #4**

- `s`에는 영단어로 바뀐 부분이 없습니다.

---

### 제한시간 안내

- 정확성 테스트 : 10초

### 나의 풀이

1. 영단어와 그에 부합하는 숫자를 배열에 넣는다.
2. s에서 영단어를 그에 부합하는 숫자로 바꿔준다.
3. 정수로 바꿔준다.

```java
class Solution {
        public int solution(String s) {
            String[] strings={"zero","one","two","three","four","five","six","seven","eight","nine"};
            String[] ints ={"0","1","2","3","4","5","6","7","8","9"};
            StringBuilder stringBuilder = new StringBuilder(s);
            for(int i=0;i<strings.length;i++){
               s= s.replace(strings[i],ints[i]);
            }
            
           
            return Integer.parseInt(s);
        }
    }
```