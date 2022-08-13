---
layout: post
title:  "[알고리즘]   모의고사"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 42840
comments: false
---
### **문제 설명**

수포자는 수학을 포기한 사람의 준말입니다. 수포자 삼인방은 모의고사에 수학 문제를 전부 찍으려 합니다. 수포자는 1번 문제부터 마지막 문제까지 다음과 같이 찍습니다.

1번 수포자가 찍는 방식: 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, ...2번 수포자가 찍는 방식: 2, 1, 2, 3, 2, 4, 2, 5, 2, 1, 2, 3, 2, 4, 2, 5, ...3번 수포자가 찍는 방식: 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, ...

1번 문제부터 마지막 문제까지의 정답이 순서대로 들은 배열 answers가 주어졌을 때, 가장 많은 문제를 맞힌 사람이 누구인지 배열에 담아 return 하도록 solution 함수를 작성해주세요.

### 제한 조건

- 시험은 최대 10,000 문제로 구성되어있습니다.
- 문제의 정답은 1, 2, 3, 4, 5중 하나입니다.
- 가장 높은 점수를 받은 사람이 여럿일 경우, return하는 값을 오름차순 정렬해주세요.

### 입출력 예

[제목 없음](https://www.notion.so/09abb48ee88e41c4b19d9d29db0b8da9)

### 입출력 예 설명

입출력 예 #1

- 수포자 1은 모든 문제를 맞혔습니다.
- 수포자 2는 모든 문제를 틀렸습니다.
- 수포자 3은 모든 문제를 틀렸습니다.

따라서 가장 문제를 많이 맞힌 사람은 수포자 1입니다.

입출력 예 #2

- 모든 사람이 2문제씩을 맞췄습니다.

### 나의 풀이

1. 3명의 정답들을 배열에 저장한다.
2. 각 배열의 길이로 나눈 나머지가 정답이면 correct를 증가시킨다.
3. correct가 제일 많은 사람을  찾는다.

```java
class Solution {

      public static int[] solution(int[] answers) {
        int [] person1 = {1,2,3,4,5};
        int [] person2 = {2,1,2,3,2,4,2,5};
        int [] person3 = {3,3,1,1,2,2,4,4,5,5};

        int correct1 = 0, correct2 = 0, correct3 = 0 ;

        for(int i=0;i<answers.length;i++){
            int answer =answers[i];
            if(person1[i%5]==answer) correct1++;
            if(person2[i%8]==answer) correct2++;
            if(person3[i%10]==answer) correct3++;
        }

        if(correct1>correct2){
            if(correct1>correct3) return new int[]{1};
            else if(correct1<correct3) return new int[]{3};
            else return new int[]{1,3};
        }else if(correct2>correct1){
            if(correct2>correct3) return new int[]{2};
            else if(correct2<correct3) return new int[]{3};
            else return new int[]{2,3};
        }else{
            if(correct1>correct3) return new int[]{1,2};
            else if(correct1<correct3) return new int[]{3};
            else return new int[]{1,2,3};
        }
        }
}
```