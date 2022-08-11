---
layout: post
title:  "[알고리즘] 소수 찾기"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12921
comments: false
---
### **문제 설명**

1부터 입력받은 숫자 n 사이에 있는 소수의 개수를 반환하는 함수, solution을 만들어 보세요.

소수는 1과 자기 자신으로만 나누어지는 수를 의미합니다.(1은 소수가 아닙니다.)

### 제한 조건

- n은 2이상 1000000이하의 자연수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/eed567572ea74e24ad944151530bafa5)

### 입출력 예 설명

입출력 예 #11부터 10 사이의 소수는 [2,3,5,7] 4개가 존재하므로 4를 반환

입출력 예 #21부터 5 사이의 소수는 [2,3,5] 3개가 존재하므로 3를 반환

### 나의 풀이 과정

1. 2부터 자신까지의 수를 나누어 떨어지는 수가 하나도 없는 수를 찾아 개수를 더해준다.
    1. 위 방법으로 시행 시 시간초과로 인해 실패하는 케이스가 생겼다. 속도를 좀 더 빨리 할 수 있는 방법이 없을 까 생각하다가 이미 구한 소수들을 저장 후 그 리스트를 이용해 소수를 구하는 방법을 생각 했다. (2.의 방법)
2. 2부터 n까지의 수가 리스트에 저장된 소수들로 나누어 떨어지면 개수를 더해주고 소수리스트에 추가한다.
    1. 위 방법으로 소수의 개수를 저장하니 속도가 빨라져 정확도 테스트는 모두 성공했지만, 효율성 테스트에서 실패하였다. 반복하는 갯수가 너무 많아 문제가 테스트에 실패 한 건가 싶어 다른 방법을 생각했다.
3. 2부터 n까지의 수 중 구한 소수의 배수에 해당하는 수들을 모두 삭제하여 마지막에 남아있는 수의 갯수르 반환한다.

위 세가지 방법 모두 효율성 테스트를 통과하지 못해 무엇이 문제일까 찾아보던 중 2부터 n의 루트까지만 반복시켜 소수를 찾으면 갯수를 구할 수 있다는 것을 알게되었고 그것을 적용하니 3가지 방법 모두 통과하는 것을 볼 수 있었다.

### 나의 풀이1

```java
import java.util.ArrayList;
  
 class Solution {
  public static int solution(int n) {
        int answer = 0;

        int root = (int) Math.sqrt(n);
        for (int i = 2; i <= n; i++) {
            if(i>root){
                if(isPrime(i, root)) answer++;
            }else if (isPrime(i)) {
                answer++;
            }

        }
        return answer;
    }

    public static boolean isPrime(int num) {
        for (int i = 2; i < num; i++) {
            if (num % i == 0) return false;
        }
        return true;
    }

    public static boolean isPrime(int num,int root) {
        for (int i = 2; i <= root; i++) {
            if (num % i == 0) return false;
        }
        return true;
    }

    }
```

### 나의 풀이2

```java
import java.util.ArrayList;
  
 class Solution {
public static int solution(int n) {
        int answer = 0;
        ArrayList<Integer> primes = new ArrayList<>();
        int root = (int) Math.sqrt(n);
        for (int i = 2; i <= n; i++) {
            if (isPrime(i,primes)) {
                answer++;
                if(i<=root)primes.add(i);
            }
        }

        return answer;
    }

    public static boolean isPrime(int num, ArrayList<Integer> primes) {
        for (int p : primes) {
            if (num % p == 0) return false;
        }
        return true;
    }

    }
```

### 나의 풀이3

```java
import java.util.ArrayList;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
  
 class Solution {
public static int solution(int n) {
        int answer = 0;
        ArrayList<Integer> arr = new ArrayList<>();
        int root = (int) Math.sqrt(n);
        for (int i = 2; i <= n; i++) {
            arr.add(i);
        }
        // arr= (ArrayList<Integer>) Arrays.stream(IntStream.rangeClosed(2, n).toArray()).boxed().collect(Collectors.toList());
        int index = 0;
        while (arr.size() > index) {
            int num = arr.get(index);
            answer++;
            if (num <= root) arr.removeIf(i -> i != num && i % num == 0);
            index++;
        }
        return answer;
    }

    }
```