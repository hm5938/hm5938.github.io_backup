---
layout: post
title:  "[알고리즘]   1차 비밀지도"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 17681
comments: false
---
### 문제 설명

# **비밀지도**

네오는 평소 프로도가 비상금을 숨겨놓는 장소를 알려줄 비밀지도를 손에 넣었다. 그런데 이 비밀지도는 숫자로 암호화되어 있어 위치를 확인하기 위해서는 암호를 해독해야 한다. 다행히 지도 암호를 해독할 방법을 적어놓은 메모도 함께 발견했다.

1. 지도는 한 변의 길이가 `n`인 정사각형 배열 형태로, 각 칸은 "공백"(" ") 또는 "벽"("#") 두 종류로 이루어져 있다.
2. 전체 지도는 두 장의 지도를 겹쳐서 얻을 수 있다. 각각 "지도 1"과 "지도 2"라고 하자. 지도 1 또는 지도 2 중 어느 하나라도 벽인 부분은 전체 지도에서도 벽이다. 지도 1과 지도 2에서 모두 공백인 부분은 전체 지도에서도 공백이다.
3. "지도 1"과 "지도 2"는 각각 정수 배열로 암호화되어 있다.
4. 암호화된 배열은 지도의 각 가로줄에서 벽 부분을 `1`, 공백 부분을 `0`으로 부호화했을 때 얻어지는 이진수에 해당하는 값의 배열이다.

![http://t1.kakaocdn.net/welcome2018/secret8.png](http://t1.kakaocdn.net/welcome2018/secret8.png)

네오가 프로도의 비상금을 손에 넣을 수 있도록, 비밀지도의 암호를 해독하는 작업을 도와줄 프로그램을 작성하라.

### **입력 형식**

입력으로 지도의 한 변 크기 `n` 과 2개의 정수 배열 `arr1`, `arr2`가 들어온다.

- 1 ≦ `n` ≦ 16
- `arr1`, `arr2`는 길이 `n`인 정수 배열로 주어진다.
- 정수 배열의 각 원소 `x`를 이진수로 변환했을 때의 길이는 `n` 이하이다. 즉, 0 ≦ `x` ≦ 2 - 1을 만족한다.
    
    n
    

### **출력 형식**

원래의 비밀지도를 해독하여 `'#'`, `공백`으로 구성된 문자열 배열로 출력하라.

### **입출력 예제**

[제목 없음](https://www.notion.so/ec67ef1c406e4a80ae149708359c06dc)

[제목 없음](https://www.notion.so/b9662896212c46759d7f0a79a38362f1)

### 나의 풀이

1. 지도 1과 지도2를 이진수로 바꿔준다.
2. n의 길이로 이진수string의 길이를 맞춰준다.
3. 같은 위치의 문자가 0이면 공백 아니면 #을 더한다.
4. 더해진 String의 배열을 반환한다.

```java
class Solution {
        public String[] solution(int n, int[] arr1, int[] arr2) {
            String[] answer = new String[n];

            for(int i=0;i<n;i++){
                String binaryString1 = Integer.toBinaryString(arr1[i]);
                String binaryString2 = Integer.toBinaryString(arr2[i]);

                if(binaryString1.length()<n){
                    binaryString1="0".repeat(n-binaryString1.length())+binaryString1;
                }
                if(binaryString2.length()<n){
                    binaryString2="0".repeat(n-binaryString2.length())+binaryString2;
                }

                String resultString = "";
                for(int j=0;j<n;j++){
                    if(binaryString1.charAt(j)=='0'&&binaryString2.charAt(j)=='0') resultString += " ";
                    else resultString += "#";
                }
                answer[i] = resultString;
            }
            return answer;
        }
    }
```