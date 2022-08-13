---
layout: post
title:  "[알고리즘]   [1차]다트게임"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 17682
comments: false
---
### **문제 설명**

# **다트 게임**

카카오톡에 뜬 네 번째 별! 심심할 땐? 카카오톡 게임별~

![http://t1.kakaocdn.net/welcome2018/gamestar.png](http://t1.kakaocdn.net/welcome2018/gamestar.png)

카카오톡 게임별의 하반기 신규 서비스로 다트 게임을 출시하기로 했다. 다트 게임은 다트판에 다트를 세 차례 던져 그 점수의 합계로 실력을 겨루는 게임으로, 모두가 간단히 즐길 수 있다.갓 입사한 무지는 코딩 실력을 인정받아 게임의 핵심 부분인 점수 계산 로직을 맡게 되었다. 다트 게임의 점수 계산 로직은 아래와 같다.

1. 다트 게임은 총 3번의 기회로 구성된다.
2. 각 기회마다 얻을 수 있는 점수는 0점에서 10점까지이다.
3. 점수와 함께 Single(`S`), Double(`D`), Triple(`T`) 영역이 존재하고 각 영역 당첨 시 점수에서 1제곱, 2제곱, 3제곱 (점수 , 점수 , 점수 )으로 계산된다.
    
    1
    
    2
    
    3
    
4. 옵션으로 스타상(``) , 아차상(`#`)이 존재하며 스타상(``) 당첨 시 해당 점수와 바로 전에 얻은 점수를 각 2배로 만든다. 아차상(`#`) 당첨 시 해당 점수는 마이너스된다.
5. 스타상(``)은 첫 번째 기회에서도 나올 수 있다. 이 경우 첫 번째 스타상(``)의 점수만 2배가 된다. (예제 4번 참고)
6. 스타상(``)의 효과는 다른 스타상(``)의 효과와 중첩될 수 있다. 이 경우 중첩된 스타상(``) 점수는 4배가 된다. (예제 4번 참고)
7. 스타상(``)의 효과는 아차상(`#`)의 효과와 중첩될 수 있다. 이 경우 중첩된 아차상(`#`)의 점수는 -2배가 된다. (예제 5번 참고)
8. Single(`S`), Double(`D`), Triple(`T`)은 점수마다 하나씩 존재한다.
9. 스타상(``), 아차상(`#`)은 점수마다 둘 중 하나만 존재할 수 있으며, 존재하지 않을 수도 있다.

0~10의 정수와 문자 S, D, T, *, #로 구성된 문자열이 입력될 시 총점수를 반환하는 함수를 작성하라.

### **입력 형식**

"점수|보너스|[옵션]"으로 이루어진 문자열 3세트.예) `1S2D*3T`

- 점수는 0에서 10 사이의 정수이다.
- 보너스는 S, D, T 중 하나이다.
- 옵선은 *이나 # 중 하나이며, 없을 수도 있다.

### **출력 형식**

3번의 기회에서 얻은 점수 합계에 해당하는 정수값을 출력한다.예) 37

### **입출력 예제**

[제목 없음](https://www.notion.so/ea2246ecd77046d0a01cd675effbc580)

### 나의 풀이

1. 문자열 패턴에 맞춰 string을 잘라준다.
2. 각 문자에서 점수와 보너스를 찾아 적용시킨다.
3. 옵션에 따라 현재 점수와 이전점수를 곱해준다.
4. 옵션적용이 모두 끝난 이전점수를 더해 점수의 합을 계산한다.

```java
import java.util.regex.Matcher;
import java.util.regex.Pattern;
class Solution {
  public static int solution(String dartResult) {
            int answer = 0;
            int score=0;
            int option =0; 

            Pattern p = Pattern.compile("[0-9]+[A-Z][*|#]?");	// 검색할 문자열 패턴 
            Matcher m = p.matcher(dartResult);			// 문자열 설정
            int pre_score =0;
            while (m.find()) {
                String str = m.group();
                String[]temp_str = new String[3];
                if(str.contains("S")){
                    temp_str=str.split("S");
                   score = Integer.parseInt(temp_str[0]);
                }else if(str.contains("D")){
                    temp_str=str.split("D");
                  score = (int) Math.pow(Integer.parseInt(temp_str[0]),2);
                }else if(str.contains("T")){
                   temp_str=str.split("T");
                  score = (int) Math.pow(Integer.parseInt(temp_str[0]),3);
                }

                if(temp_str.length>1){
                    switch (temp_str[1]){
                        case "*":
                            pre_score*=2;
                            score*=2;
                            option =2;
                            break;
                        case "#":
                            score*=-1;
                            option =1;
                            break;
                        default:
                            option=0;
                            
                    }
                }else{
                    option =0;
                }
       
                answer += pre_score;
                pre_score = score;
                System.out.println(m.group());
            }
            answer += score;

            return answer;
        }

}
```