---
layout: post
title:  "[알고리즘]   최대공약수와 최소공배수"
subtitle: "test"
categories: algorithm
tags: algorithm programmers 12940
comments: false
---
### **문제 설명**

두 수를 입력받아 두 수의 최대공약수와 최소공배수를 반환하는 함수, solution을 완성해 보세요. 배열의 맨 앞에 최대공약수, 그다음 최소공배수를 넣어 반환하면 됩니다. 예를 들어 두 수 3, 12의 최대공약수는 3, 최소공배수는 12이므로 solution(3, 12)는 [3, 12]를 반환해야 합니다.

### 제한 사항

- 두 수는 1이상 1000000이하의 자연수입니다.

### 입출력 예

[제목 없음](https://www.notion.so/9b0c50d37aee4fdca87a0b5b5b5a4be1)

### 입출력 예 설명

입출력 예 #1위의 설명과 같습니다.

입출력 예 #2자연수 2와 5의 최대공약수는 1, 최소공배수는 10이므로 [1, 10]을 리턴해야 합니다.

### 나의 풀이

1. 2부터 자신까지 나누어 떨어지는 수가 한개도 없다면 소수라고 판단
2. n의 약수 중에 소수인 수들을 구한다.
3. n과 m의 소수 리스트 중 같은 수를 모두 곱하여 최대공약수를 찾는다.
4. n과 m의 소수 리스트 를 하나로 합친 후 모두 곱해준다. (중복되는 것은 하나로 생각한다.)

```java
import java.util.ArrayList;
    class Solution {
                public int[] solution(int n, int m) {
            int divisor = getDivisor(n,m);
            int multiple = getMultiple(n,m);
            return new int[]{divisor,multiple};
        }

        //최대공약수반환 : 같은 소수를 모두 곱해준다
        public int getDivisor(int n, int m){
            int result =1;
            ArrayList<Integer> arrayn = getPrimes(n);
            ArrayList<Integer> arraym = getPrimes(m);

            for(Integer a :arraym){
                if(arrayn.contains(a)){
                    arrayn.remove(a);
                    result *= a;
                }
            }

            return result;
        }

        //최대공배수반환 : 소수의 집합들을 하나로 합친 후 곱해준다
        public int getMultiple(int n, int m){
            int result =1;
            ArrayList<Integer> arrayn = getPrimes(n);
            ArrayList<Integer> arraym = getPrimes(m);
            ArrayList<Integer> total = new ArrayList<>();
            total.addAll(arraym);
            total.addAll(arrayn);
            for(Integer a: arraym){
                if(arrayn.contains(a)){
                    total.remove(a);
                    arrayn.remove(a);
                }
            }

            for(int i:total) result *=i;

            return result;
        }

        //n이 이루고 있는 소수의 집합
        public ArrayList<Integer> getPrimes(int n){
            ArrayList<Integer> result = new ArrayList<>();
            while(!isPrime(n)){
                for(int i=2;i<=n;i++){
                    if(isPrime(i)){
                        if(n%i==0) {
                            result.add(i);
                            n = n/i;
                            break;
                        }
                    }
                }
            }
            result.add(n);

            return result;
        }

        public boolean isPrime(int num) {
            if(num==1) return true;
            for (int i = 2; i < num; i++) {
                if (num % i == 0) return false;
            }
            return true;
        }
    }
```