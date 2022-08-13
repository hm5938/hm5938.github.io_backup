---
layout: post
title:  "[알고리즘]   실패율"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 42889
comments: false
---
### **문제 설명**

# **실패율**

![https://grepp-programmers.s3.amazonaws.com/files/production/bde471d8ac/48ddf1cc-c4ea-499d-b431-9727ee799191.png](https://grepp-programmers.s3.amazonaws.com/files/production/bde471d8ac/48ddf1cc-c4ea-499d-b431-9727ee799191.png)

슈퍼 게임 개발자 오렐리는 큰 고민에 빠졌다. 그녀가 만든 프랜즈 오천성이 대성공을 거뒀지만, 요즘 신규 사용자의 수가 급감한 것이다. 원인은 신규 사용자와 기존 사용자 사이에 스테이지 차이가 너무 큰 것이 문제였다.

이 문제를 어떻게 할까 고민 한 그녀는 동적으로 게임 시간을 늘려서 난이도를 조절하기로 했다. 역시 슈퍼 개발자라 대부분의 로직은 쉽게 구현했지만, 실패율을 구하는 부분에서 위기에 빠지고 말았다. 오렐리를 위해 실패율을 구하는 코드를 완성하라.

- 실패율은 다음과 같이 정의한다.
    - 스테이지에 도달했으나 아직 클리어하지 못한 플레이어의 수 / 스테이지에 도달한 플레이어 수

전체 스테이지의 개수 N, 게임을 이용하는 사용자가 현재 멈춰있는 스테이지의 번호가 담긴 배열 stages가 매개변수로 주어질 때, 실패율이 높은 스테이지부터 내림차순으로 스테이지의 번호가 담겨있는 배열을 return 하도록 solution 함수를 완성하라.

### 제한사항

- 스테이지의 개수 N은 `1` 이상 `500` 이하의 자연수이다.
- stages의 길이는 `1` 이상 `200,000` 이하이다.
- stages에는 `1` 이상 `N + 1` 이하의 자연수가 담겨있다.
    - 각 자연수는 사용자가 현재 도전 중인 스테이지의 번호를 나타낸다.
    - 단, `N + 1` 은 마지막 스테이지(N 번째 스테이지) 까지 클리어 한 사용자를 나타낸다.
- 만약 실패율이 같은 스테이지가 있다면 작은 번호의 스테이지가 먼저 오도록 하면 된다.
- 스테이지에 도달한 유저가 없는 경우 해당 스테이지의 실패율은 `0` 으로 정의한다.

### 입출력 예

[제목 없음](https://www.notion.so/9801c778bd0f44c9babed344a15b2c36)

### 입출력 예 설명

입출력 예 #11번 스테이지에는 총 8명의 사용자가 도전했으며, 이 중 1명의 사용자가 아직 클리어하지 못했다. 따라서 1번 스테이지의 실패율은 다음과 같다.

- 1 번 스테이지 실패율 : 1/8

2번 스테이지에는 총 7명의 사용자가 도전했으며, 이 중 3명의 사용자가 아직 클리어하지 못했다. 따라서 2번 스테이지의 실패율은 다음과 같다.

- 2 번 스테이지 실패율 : 3/7

마찬가지로 나머지 스테이지의 실패율은 다음과 같다.

- 3 번 스테이지 실패율 : 2/4
- 4번 스테이지 실패율 : 1/2
- 5번 스테이지 실패율 : 0/1

각 스테이지의 번호를 실패율의 내림차순으로 정렬하면 다음과 같다.

- [3,4,2,1,5]

입출력 예 #2

모든 사용자가 마지막 스테이지에 있으므로 4번 스테이지의 실패율은 1이며 나머지 스테이지의 실패율은 0이다.

- [4,1,2,3]

### 나의 풀이

1. 각 스테이지의 실패율을 저장한 hashmap을 생성하여 스테이지번호와 0.0을 초기화 해준다.
2. 스테이지 별 속해있는 사람의 수를 구하기 위해 person을 N+1만큼의 크기로 생성하여 0으로 초기화 해준다.
3. stage배열을 정렬한다.
4. 제일 높은 stage부터 사람의 수를 구한다. 이때 stage가 바뀌면 그 전 stage의 실패율로 함께 저장해준다.
5. 남은 stage의 실패율을 구해 넣어준다. 
6. map.entry리스트로 hashmap을 정렬해준다.

```java
import java.util.*;
  
 class Solution {
  public static int[] solution(int N, int[] stages) {
            HashMap<Integer,Double> fails = new HashMap<>();
            int [] person = new int[N+1];
            int []answer = new int[N];

                 for(int i=0;i<N;i++){
                fails.put(i+1,0.0);
                person[i]=0;
            }
            Arrays.sort(stages);
            int sum =0;
            for(int i = stages.length-1;i>=0;i--){
                if(i!=stages.length-1) {
                    if(stages[i+1]!=stages[i]) {
                        int complete = stages[i+1]-1;
                       if(stages[i+1]!=N+1){
                           for(int j=complete; j>stages[i]-1;j--){
                               fails.put(j+1,(double)(person[j])/sum);
                               System.out.println(j+1+" : "+(double)(person[j])/sum);
                           }

                       }
                    }
                }
                person[stages[i]-1]++;
                sum+= 1;
            }
            
            for(int i=0;i<stages[0];i++){
                fails.put(i+1,(double)person[i]/sum);
            }
            // Map.Entry 리스트 작성
            List<Map.Entry<Integer, Double>> list_entries = new ArrayList<Map.Entry<Integer, Double>>(fails.entrySet());

            // 비교함수 Comparator를 사용하여 오름차순으로 정렬
            Collections.sort(list_entries, new Comparator<Map.Entry<Integer, Double>>() {
                // compare로 값을 비교
                public int compare(Map.Entry<Integer, Double> obj1, Map.Entry<Integer, Double> obj2) {
                    // 오름 차순 정렬
                    if(obj1.getValue().equals(obj2.getValue())) return obj2.getKey()-obj1.getKey();
                    else return obj1.getValue().compareTo(obj2.getValue());
                }
            });
            int index =N;
            for(Map.Entry<Integer,Double> entity:list_entries){
                 if(index>0) answer[--index] = (int) entity.getKey();
            }

            return answer;
        }

    }
```