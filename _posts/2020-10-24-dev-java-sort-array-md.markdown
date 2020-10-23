---
layout: post
title:  "[Java] 배열 정렬하기"
subtitle: "java"
categories: dev
tags: dev java function  
comments: false
---

## 개요
> 자바에서 배열이나 리스트를 정렬하려고 한다면 java.util.Arrays 클래스의 sort() 메서드를 사용하면 따로 정렬 로직을 짜지 않아도 한번의 메소드 호출로 간편하게 배열이나 리스트를 정렬할 수 있다.
  
- 목차
	- [오름차순 정렬](#오름차순-정렬) 
	- [내림차순 정렬](#내림차순-정렬)
	- [일부분만 정렬](#일부분만-정렬)
	- [객체 배열 정렬](#객체-배열-정렬)
	
 
## 오름차순 정렬
---
```java
Arrays.sort(arr);
```

## 내림차순 정렬
두번째 인자값에 Collections.reverseOrder()를 추가해준다.

```java
Arrays.sort(arr , Collections.reverseOrder());
```
## 일부분만 정렬
만약 일부분만 정렬하고 싶다면 정렬하고 싶은 범위의 index를 인자값에 추가해 준다.
```java
Arrays.sort(arr , 처음 , 끝);
Arrays.sort(arr, 0, 4); // 0,1,2,3 요소만 정렬
```

## 객체 배열 정렬
객체로 이루어진 배열의 경우에는 객체 클래스가 Comparable 인터페이스의 compareTo() 메서드를 구현하고 있어야 정렬이 된다

먼저 class에 Comparable 인터페이스를 implement 해주고 comparTo() 메서드를 구현해준다.
```java
class People implements Comparable {

	private String name;
    private int age;
    
    public People(String name, int age){
        this.name = name;
        this.age= age;
    }

	@Override
    public int compareTo(People people) {
		 //비교 조건 적어주기 (아래예시)
         if (this.age < people.age) {
             return -1;
         } else if (this.age == people.age) {
             return 0;
         } else {
             return 1;
         }
     }
}
```
Arrays.sort를 사용해 정렬

```java
public class Sort{
     public static void main(String[] args)  {
         People[] arr = { new People("상현", 20)
            , new People("철수", 14)
            , new People("경완", 31)
            , new People("대호", 40)
            , new People("지운", 24) 
        };
		
        Arrays.sort(arr); //오름차순 정렬
		
        for (People i : arr) { //오름차순 출력
            System.out.print("["+i.print()+"]");
        }
		
        Arrays.sort(arr,Collections.reverseOrder()); //내림차순 정렬
        System.out.println();
		
        for (People i : arr) { //내림차순 출력
            System.out.print("["+i.print()+"]");
        }
    }
}
```
