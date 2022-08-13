---
layout: post
title:  "[알고리즘]   체육복"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 42862
comments: false
---
### **문제 설명**

점심시간에 도둑이 들어, 일부 학생이 체육복을 도난당했습니다. 다행히 여벌 체육복이 있는 학생이 이들에게 체육복을 빌려주려 합니다. 학생들의 번호는 체격 순으로 매겨져 있어, 바로 앞번호의 학생이나 바로 뒷번호의 학생에게만 체육복을 빌려줄 수 있습니다. 예를 들어, 4번 학생은 3번 학생이나 5번 학생에게만 체육복을 빌려줄 수 있습니다. 체육복이 없으면 수업을 들을 수 없기 때문에 체육복을 적절히 빌려 최대한 많은 학생이 체육수업을 들어야 합니다.

전체 학생의 수 n, 체육복을 도난당한 학생들의 번호가 담긴 배열 lost, 여벌의 체육복을 가져온 학생들의 번호가 담긴 배열 reserve가 매개변수로 주어질 때, 체육수업을 들을 수 있는 학생의 최댓값을 return 하도록 solution 함수를 작성해주세요.

### 제한사항

- 전체 학생의 수는 2명 이상 30명 이하입니다.
- 체육복을 도난당한 학생의 수는 1명 이상 n명 이하이고 중복되는 번호는 없습니다.
- 여벌의 체육복을 가져온 학생의 수는 1명 이상 n명 이하이고 중복되는 번호는 없습니다.
- 여벌 체육복이 있는 학생만 다른 학생에게 체육복을 빌려줄 수 있습니다.
- 여벌 체육복을 가져온 학생이 체육복을 도난당했을 수 있습니다. 이때 이 학생은 체육복을 하나만 도난당했다고 가정하며, 남은 체육복이 하나이기에 다른 학생에게는 체육복을 빌려줄 수 없습니다.

### 입출력 예

[제목 없음](https://www.notion.so/7731c9e772f44ad59f0b745df11c0a09)

### 입출력 예 설명

예제 #11번 학생이 2번 학생에게 체육복을 빌려주고, 3번 학생이나 5번 학생이 4번 학생에게 체육복을 빌려주면 학생 5명이 체육수업을 들을 수 있습니다.

예제 #23번 학생이 2번 학생이나 4번 학생에게 체육복을 빌려주면 학생 4명이 체육수업을 들을 수 있습니다.

[출처](http://hsin.hr/coci/archive/2009_2010/contest6_tasks.pdf)

※ 공지 - 2019년 2월 18일 지문이 리뉴얼되었습니다.※ 공지 - 2019년 2월 27일, 28일 테스트케이스가 추가되었습니다.※ 공지 - 2021년 7월 28일 테스트케이스가 추가되었습니다.※ 공지 - 2021년 8월 30일 테스트케이스가 추가되었습니다.

### 나의 풀이

1. reserve를 정렬해준다. reserve 순서대로 빌려줄 학생을 찾기 위해서
2. reserve와 lost를 arraylist로 변환해준다. 쉽게 지워주기 위해
3. reserve와 lost중 동일 한 학생이 있다면 리스트에서 지워준다. 이때 전체 계산은 원본 배열로 할 것이기 때문에 빌려준 갯수를 추가해준다. 
4. reserve갯수만큼 반복하면서 전 번호와 후 번호에 lost가 있는지 탐색 후 해당 lost를 지워준다. 빌려준 갯수도 추가 해준다.
5. 전체 학생수에서 도난당한 학생수를 뺀 후 빌려준 수를 더해 체육수업을 들을 학생수를 계산한다.

```java
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet; 
import java.util.stream.Collectors;
class Solution {
        public int solution(int n, int[] lost, int[] reserve) {
            int answer = 0;
            Arrays.sort(reserve);
            ArrayList<Integer> lost_array = (ArrayList<Integer>) Arrays.stream(lost).boxed().collect(Collectors.toList());
            ArrayList<Integer> reserve_array = (ArrayList<Integer>) Arrays.stream(reserve).boxed().collect(Collectors.toList());
            HashSet<Integer> reserves = new HashSet<>();
            
            
            for(Integer l:lost){
                if(reserve_array.contains(l)){
                    reserve_array.remove(l);
                    lost_array.remove(l);
                    reserves.add(l);
                }
            }
            for(int i=0 ;i<reserve_array.size();i++){
                int re = reserve_array.get(i);
                if(lost_array.contains((Integer)(re-1))){
                    reserves.add(re-1);
                    lost_array.remove((Integer)(re-1));
                }else if(lost_array.contains((Integer)(re+1))){
                    reserves.add(re+1);
                    lost_array.remove((Integer)(re+1));
                }
            }
            answer = n - lost.length+ reserves.size();
            return answer;
        }
    }
```

### Tip. 이때 reserve를 정렬하지 않으면 빌려주는 순서가 뒤바뀔수 있기 때문에 꼭 정렬해주어야함. test case 18,20