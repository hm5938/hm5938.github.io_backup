---
layout: post
title:  "[알고리즘]   키패드 누르기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 67256
comments: false
---
### **문제 설명**

스마트폰 전화 키패드의 각 칸에 다음과 같이 숫자들이 적혀 있습니다.

![https://grepp-programmers.s3.ap-northeast-2.amazonaws.com/files/production/4b69a271-5f4a-4bf4-9ebf-6ebed5a02d8d/kakao_phone1.png](https://grepp-programmers.s3.ap-northeast-2.amazonaws.com/files/production/4b69a271-5f4a-4bf4-9ebf-6ebed5a02d8d/kakao_phone1.png)

이 전화 키패드에서 왼손과 오른손의 엄지손가락만을 이용해서 숫자만을 입력하려고 합니다.맨 처음 왼손 엄지손가락은 `*` 키패드에 오른손 엄지손가락은 `#` 키패드 위치에서 시작하며, 엄지손가락을 사용하는 규칙은 다음과 같습니다.

1. 엄지손가락은 상하좌우 4가지 방향으로만 이동할 수 있으며 키패드 이동 한 칸은 거리로 1에 해당합니다.
2. 왼쪽 열의 3개의 숫자 `1`, `4`, `7`을 입력할 때는 왼손 엄지손가락을 사용합니다.
3. 오른쪽 열의 3개의 숫자 `3`, `6`, `9`를 입력할 때는 오른손 엄지손가락을 사용합니다.
4. 가운데 열의 4개의 숫자 `2`, `5`, `8`, `0`을 입력할 때는 두 엄지손가락의 현재 키패드의 위치에서 더 가까운 엄지손가락을 사용합니다.4-1. 만약 두 엄지손가락의 거리가 같다면, 오른손잡이는 오른손 엄지손가락, 왼손잡이는 왼손 엄지손가락을 사용합니다.

순서대로 누를 번호가 담긴 배열 numbers, 왼손잡이인지 오른손잡이인 지를 나타내는 문자열 hand가 매개변수로 주어질 때, 각 번호를 누른 엄지손가락이 왼손인 지 오른손인 지를 나타내는 연속된 문자열 형태로 return 하도록 solution 함수를 완성해주세요.

### **[제한사항]**

- numbers 배열의 크기는 1 이상 1,000 이하입니다.
- numbers 배열 원소의 값은 0 이상 9 이하인 정수입니다.
- hand는 `"left"` 또는 `"right"` 입니다.
    - `"left"`는 왼손잡이, `"right"`는 오른손잡이를 의미합니다.
- 왼손 엄지손가락을 사용한 경우는 `L`, 오른손 엄지손가락을 사용한 경우는 `R`을 순서대로 이어붙여 문자열 형태로 return 해주세요.

---

### **입출력 예**

[제목 없음](https://www.notion.so/f893fa2d36684a12ab69b9b4d42f5742)

### **입출력 예에 대한 설명**

**입출력 예 #1**

순서대로 눌러야 할 번호가 [1, 3, 4, 5, 8, 2, 1, 4, 5, 9, 5]이고, 오른손잡이입니다.

[제목 없음](https://www.notion.so/3727f75c71ab49c7b023667db0d03e15)

따라서 `"LRLLLRLLRRL"`를 return 합니다.

**입출력 예 #2**

왼손잡이가 [7, 0, 8, 2, 8, 3, 1, 5, 7, 6, 2]를 순서대로 누르면 사용한 손은 `"LRLLRRLLLRR"`이 됩니다.

**입출력 예 #3**

오른손잡이가 [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]를 순서대로 누르면 사용한 손은 `"LLRLLRLLRL"`이 됩니다.

### 나의 풀이

1. Map에 각 번호별 위치를 넣어준다.
2. number만큼 반복시킨다.
3. 만약 1,4,7이면 L을 넣고, left 위치에 해당하는 좌표값을 넣어준다.
4. 3,6,9 이면 R을 넣고, rigfht 위치에 해당하는 좌표값을 넣어준다.
5. 그 외의 번호이면 left의 이동거리와 right의 이동거리를 계산하여 짧은 거리에 해당하는 손의 좌표값을 넣어준다.
6. 두 이동거리가 같다면 hand의 좌표값을 넣어준다.

```java
import java.util.Map; 
class Solution {
        public String solution(int[] numbers, String hand) {
            String answer = "";
            Map<Integer, String> matching_loc =
                    Map.of(1, "00",
                            2, "01",
                            3, "02",
                            4, "10",
                            5, "11",
                            6, "12",
                            7, "20",
                            8, "21",
                            9, "22",
                            0, "31");
            int[] left = new int[]{3, 0};
            int[] right = new int[]{3, 2};
            for (int number : numbers) {
                String[] current = matching_loc.get(number).split("");
                int y = Integer.parseInt(current[0]), x = Integer.parseInt(current[1]);
                if (number == 1 || number == 4 || number == 7) {
                    answer += "L";
                    left[0] = y;
                    left[1] = x;
                } else if (number == 3 || number == 6 || number == 9) {
                    answer += "R";
                    right[0] = y;
                    right[1] = x;
                } else {
                  double left_len = Math.abs(left[0] - y) + Math.abs(left[1] - x);
                    double right_len =  Math.abs(right[0] - y) + Math.abs(right[1] - x);
                   
                    if (left_len > right_len) {
                        answer += "R";
                        right[0] = y;
                        right[1] = x;
                    } else if (left_len < right_len) {
                        answer += "L";
                        left[0] = y;
                        left[1] = x;
                    } else {
                        if (hand.equals("left")) {
                            answer += "L";
                            left[0] = y;
                            left[1] = x;
                        } else if (hand.equals("right")) {
                            answer += "R";
                            right[0] = y;
                            right[1] = x;
                        }
                    }
                }
            }

            return answer;
        }
    }
```

이동할 때 는 대각선으로 이동할 수 없으므로 가로거리의 절댓값과 세로거리의 절댓값을 더한 값으로 이동거리를 계산해야한다. (test case 13번 ~20번)