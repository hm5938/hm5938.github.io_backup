---
layout: post
title:  "[알고리즘]   로또의 최고 순위와 최저 순위"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 77484
comments: false
---
### **문제 설명**

`로또 6/45`(이하 '로또'로 표기)는 1부터 45까지의 숫자 중 6개를 찍어서 맞히는 대표적인 복권입니다. 아래는 로또의 순위를 정하는 방식입니다. [1](https://school.programmers.co.kr/learn/courses/30/lessons/77484#fn1)

[제목 없음](https://www.notion.so/83a19bdfea4f45c7826d4aa58292c71f)

로또를 구매한 민우는 당첨 번호 발표일을 학수고대하고 있었습니다. 하지만, 민우의 동생이 로또에 낙서를 하여, 일부 번호를 알아볼 수 없게 되었습니다. 당첨 번호 발표 후, 민우는 자신이 구매했던 로또로 당첨이 가능했던 최고 순위와 최저 순위를 알아보고 싶어 졌습니다.알아볼 수 없는 번호를 `0`으로 표기하기로 하고, 민우가 구매한 로또 번호 6개가 `44, 1, 0, 0, 31 25`라고 가정해보겠습니다. 당첨 번호 6개가 `31, 10, 45, 1, 6, 19`라면, 당첨 가능한 최고 순위와 최저 순위의 한 예는 아래와 같습니다.

[제목 없음](https://www.notion.so/d31622e709d645d0a3a63e49218e59af)

- 순서와 상관없이, 구매한 로또에 당첨 번호와 일치하는 번호가 있으면 맞힌 걸로 인정됩니다.
- 알아볼 수 없는 두 개의 번호를 각각 10, 6이라고 가정하면 3등에 당첨될 수 있습니다.
    - 3등을 만드는 다른 방법들도 존재합니다. 하지만, 2등 이상으로 만드는 것은 불가능합니다.
- 알아볼 수 없는 두 개의 번호를 각각 11, 7이라고 가정하면 5등에 당첨될 수 있습니다.
    - 5등을 만드는 다른 방법들도 존재합니다. 하지만, 6등(낙첨)으로 만드는 것은 불가능합니다.

민우가 구매한 로또 번호를 담은 배열 lottos, 당첨 번호를 담은 배열 win_nums가 매개변수로 주어집니다. 이때, 당첨 가능한 최고 순위와 최저 순위를 차례대로 배열에 담아서 return 하도록 solution 함수를 완성해주세요.

### 제한사항

- lottos는 길이 6인 정수 배열입니다.
- lottos의 모든 원소는 0 이상 45 이하인 정수입니다.
    - 0은 알아볼 수 없는 숫자를 의미합니다.
    - 0을 제외한 다른 숫자들은 lottos에 2개 이상 담겨있지 않습니다.
    - lottos의 원소들은 정렬되어 있지 않을 수도 있습니다.
- win_nums은 길이 6인 정수 배열입니다.
- win_nums의 모든 원소는 1 이상 45 이하인 정수입니다.
    - win_nums에는 같은 숫자가 2개 이상 담겨있지 않습니다.
    - win_nums의 원소들은 정렬되어 있지 않을 수도 있습니다.

---

### 입출력 예

[제목 없음](https://www.notion.so/ddac86b722074bab90fa72f33676b528)

### 입출력 예 설명

입출력 예 #1문제 예시와 같습니다.

입출력 예 #2알아볼 수 없는 번호들이 아래와 같았다면, 1등과 6등에 당첨될 수 있습니다.

[제목 없음](https://www.notion.so/d6ff75884cf14b5686e0cf73d7b03aa8)

입출력 예 #3민우가 구매한 로또의 번호와 당첨 번호가 모두 일치하므로, 최고 순위와 최저 순위는 모두 1등입니다.

---

1. 실제로 사용되는 로또 순위의 결정 방식과는 약간 다르지만, 이 문제에서는 지문에 명시된 대로 로또 순위를 결정하도록 합니다. [↩](https://school.programmers.co.kr/learn/courses/30/lessons/77484#fnref1)

### 나의 풀이

1. 사용할 수 있는 로또 번호의 수만큼의 배열을 만든다
2. lottos의 숫자 중 해당하는 번호의 배열에 true로 값을 넣는다. 0의 개수를 센다.
3. win_nums의 해당하는 번호의 배열에 값이 true 인 개수를 corrent_num에 넣어준다.
4. correct_num에 zero개수를 더한값 만큼 맞았다고 생각하고 최고순위를 구해준다
5. correct_num만큼만 맞았다고 생각하고 최저순위를 구해준다.

```java
class Solution {
    public int[] solution(int[] lottos, int[] win_nums) {
        int[] answer = new int[2];
        int zero=0;
        boolean [] all = new boolean[46];
        int correct_num=0;
        
        
        for(int i=0;i<6;i++){
            if(lottos[i]!=0){
                all[lottos[i]] = true;
            }else zero++;
        }
        
        for(int i=0;i<6;i++){
                if(win_nums[i]!=0){
                     if(all[win_nums[i]])
                         correct_num++;
            }else zero++; 
        }
        
        if((6-(correct_num+zero))<=0) answer[0]=1;
        else if((6-(correct_num+zero))+1>=6) answer[0]=6;
        else         answer[0]= (6-(correct_num+zero))+1;
    
        
        if((6-(correct_num)+1)>=6) answer[1]=6;
        else answer[1] = 6-correct_num+1;
            
            
        return answer;
    }
}
```

정리할 때 보니 win_nums에는 zero가 없고, 숫자들이 중복되지도 않아 더 간단하게 풀 수 있을 것 같아 다시 풀어보았다. 

### 나의 풀이2

1. lottos 가 0인 갯수와 로또번호가 같은 갯수를 구한다
2. 0인 갯수와 로또번호와 같은 갯수를 더한 값으로 최고순위를 구한다
3. 로또번호와 같은 갯수로 최저 순위를 구한다

```java
import java.util.Arrays;
class Solution {
    public int[] solution(int[] lottos, int[] win_nums) {
        int[] answer = new int[2];
        int zero=0; int correct=0;

        for(int lotto: lottos){
            if(lotto==0) zero++;
            else if(Arrays.stream(win_nums).anyMatch(i->i==lotto)) correct++;
        }

        
        answer[0]=(correct+zero)>1?7-(correct+zero):6;
        answer[1]=correct>1?7-correct:6;

        return answer;
    }
}
```