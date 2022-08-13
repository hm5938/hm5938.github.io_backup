---
layout: post
title:  "[알고리즘]   K번째 수"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 42748
comments: false
---
### **문제 설명**

배열 array의 i번째 숫자부터 j번째 숫자까지 자르고 정렬했을 때, k번째에 있는 수를 구하려 합니다.

예를 들어 array가 [1, 5, 2, 6, 3, 7, 4], i = 2, j = 5, k = 3이라면

1. array의 2번째부터 5번째까지 자르면 [5, 2, 6, 3]입니다.
2. 1에서 나온 배열을 정렬하면 [2, 3, 5, 6]입니다.
3. 2에서 나온 배열의 3번째 숫자는 5입니다.

배열 array, [i, j, k]를 원소로 가진 2차원 배열 commands가 매개변수로 주어질 때, commands의 모든 원소에 대해 앞서 설명한 연산을 적용했을 때 나온 결과를 배열에 담아 return 하도록 solution 함수를 작성해주세요.

### 제한사항

- array의 길이는 1 이상 100 이하입니다.
- array의 각 원소는 1 이상 100 이하입니다.
- commands의 길이는 1 이상 50 이하입니다.
- commands의 각 원소는 길이가 3입니다.

### 입출력 예

[제목 없음](https://www.notion.so/d70b5a1cf2094a07b7adb3f5f6e52a30)

### 입출력 예 설명

[1, 5, 2, 6, 3, 7, 4]를 2번째부터 5번째까지 자른 후 정렬합니다. [2, 3, 5, 6]의 세 번째 숫자는 5입니다.[1, 5, 2, 6, 3, 7, 4]를 4번째부터 4번째까지 자른 후 정렬합니다. [6]의 첫 번째 숫자는 6입니다.[1, 5, 2, 6, 3, 7, 4]를 1번째부터 7번째까지 자릅니다. [1, 2, 3, 4, 5, 6, 7]의 세 번째 숫자는 3입니다.

### 나의 풀이

1. array를 복사하여 i부터 j까지 자른 후 정렬한다. 
2. k번째 숫자를 배열에 추가한다.
3. commands 수만큼 반복한다. 

```java
import java.util.Arrays;   
class Solution {
        public int[] solution(int[] array, int[][] commands) {
            int[] answer = new int[commands.length];

            for(int l=0;l<commands.length;l++){
                int i = commands[l][0]-1,j = commands[l][1]-1, k= commands[l][2]-1;
                int [] temp_array = Arrays.copyOfRange(array ,i,j+1);
                Arrays.sort(temp_array);
                answer[l]=temp_array[k];
            }

            return answer;
        }
        
    }
```