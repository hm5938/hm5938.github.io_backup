---
layout: post
title:  "[알고리즘] 나누어 떨어지는 숫자 배열"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12910
comments: false
---
### **문제 설명**

array의 각 element 중 divisor로 나누어 떨어지는 값을 오름차순으로 정렬한 배열을 반환하는 함수, solution을 작성해주세요.divisor로 나누어 떨어지는 element가 하나도 없다면 배열에 -1을 담아 반환하세요.

### 제한사항

- arr은 자연수를 담은 배열입니다.
- 정수 i, j에 대해 i ≠ j 이면 arr[i] ≠ arr[j] 입니다.
- divisor는 자연수입니다.
- array는 길이 1 이상인 배열입니다.

### 입출력 예

[제목 없음](https://www.notion.so/9b39f9d5c284486aa32298d1e51937a5)

### 입출력 예 설명

입출력 예#1arr의 원소 중 5로 나누어 떨어지는 원소는 5와 10입니다. 따라서 [5, 10]을 리턴합니다.

입출력 예#2arr의 모든 원소는 1으로 나누어 떨어집니다. 원소를 오름차순으로 정렬해 [1, 2, 3, 36]을 리턴합니다.

입출력 예#33, 2, 6은 10으로 나누어 떨어지지 않습니다. 나누어 떨어지는 원소가 없으므로 [-1]을 리턴합니다.

### 나의 풀이

1. arr만큼 반복하여 divisor로 나눈 나머지 값이 0. 즉 나누어 떨어지면 배열에 a추가
2. 배열 값이 없다면 -1추가
3. 오름차순으로 정렬

```python
def solution(arr, divisor):
answer = []
for a in arr:
	if a% divisor ==0: #divisor로 나눈 나머지 값이 0. 즉 나누어 떨어지면 배열에 a추가
		answer.append(a)

if len(answer)==0: #배열 값이 없다면 -1추가
	answer.append(-1)

answer.sort() #오름차순으로 정렬
return answer
```

```java
import java.util.ArrayList;
import java.util.Arrays;
class Solution {
        public int[] solution(int[] arr, int divisor) {
            
            ArrayList<Integer> result = new ArrayList<>();

//divisor로 나눈 나머지 값이 0. 즉 나누어 떨어지면 배열에 a추가
            for(int a:arr){
                if(a%divisor==0){
                    result.add(a);
                }
            }

///배열 값이 없다면 -1추가
            if(result.size()==0){
                result.add(-1);
            }
            
//ArrayList -> int[] 형 변환
            int[] answer = result.stream()
                        .mapToInt(Integer::intValue)
                        .toArray();
            
//오름차순으로 정렬
            Arrays.sort(answer);

            
            return answer;
        }
}
```