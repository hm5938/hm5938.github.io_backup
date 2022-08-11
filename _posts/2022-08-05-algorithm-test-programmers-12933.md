---
layout: post
title:  "[알고리즘]   정수 내림차순으로 배치하기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12933
comments: false
---
### **문제 설명**

함수 solution은 정수 n을 매개변수로 입력받습니다. n의 각 자릿수를 큰것부터 작은 순으로 정렬한 새로운 정수를 리턴해주세요. 예를들어 n이 118372면 873211을 리턴하면 됩니다.

### 제한 조건

- `n`은 1이상 8000000000 이하인 자연수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/ac1a526af80a48c982af8eb8a64f774e)

### 나의 풀이

1. 자리수를 String 배열로 저장한다.
2. 배열의 순서를 뒤집는다.
3. 배열을 합쳐 정수로 바꾸어준다.

```python
def solution(n):
    list_str = list(str(n))
    list_str.reverse()
    list_str.sort(reverse=True)

    answer = int(''.join(list_str))

    return answer
```

```java
import java.util.Arrays;
import java.util.Collections;

    class Solution {
        public long solution(long n) {
            String [] list = new String[Long.toString(n).length()];
            int i = 0;
            while(n>0){
                list[i++] = Integer.toString((int)(n%10));
                n=n/10;
            }
            Arrays.sort(list, Collections.reverseOrder());

            String answer = String.join("",list);
            return Long.parseLong(answer);
        }
    }
```

tip. log10으로도 자릿수를 구할 수 있다.