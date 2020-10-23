---
layout: post
title:  "[RxJava] RxJava 알아보기 - 리액티브 프로그래밍(Reactive Programming)이란?"
subtitle: "Rxjava"
categories: android
tags: android rxjava intro reactive programming  
comments: true
---


## 개요
> `Reactive Programming`을 알아보자  
  
- 목차
	- [Reactive Progamming이란?](#reactive-programming이란) 
	- [Reactive Programming에 등장하는 용어정리 (반드시 알아야 하는)](#reactive-programming에-등장하는-용어정리-반드시-알아야-하는)
	- [Reactive Programming (RxJava) 의 기본적인 구조](#reactive-programming-rxjava-의-기본적인-구조)
	
  
## Reactive Programming이란?  
---
`Reactive Programming`은 문서 작성을 지원하는 태그(Tag) 형식의 문법이다. 

> __What is Reacrive Programming? (출처 - 위키피디아)__  
> In computing, reactive programming is a `declarative programming` paradigm concerned with `data streams` and `the propagation of change`. 
> = `변화의 전파와 데이터 흐름`과 관련된 `선언적 프로그래밍 패러다임`.
- `변화의 전파와 데이터 흐름` : 데이터가 변경 될 때 마다 이벤트를 발생시켜서 데이터를 계속적으로 전달한다.
- `선언적 프로그래밍 패러다임` : 실행할 동작을 구체적으로 명시하는 명령형 프로그래밍과 달리 선언형 프로그래밍은 단순히 목표를 선언한다.

* __Push 방식과 Pull 방식
- push 방식 : 데이터의 변화가 발생했을 때 변경이 발생한 곳에서 데이터를 보내주는 방식
> * RTC(Real Time Communication)
> * 소켓 프로그래밍
> * DB Trigger
> * Spring 의 ApplicationEvent
> * Angualr의 데이터 바인딩
> * 스마트퐁의 Push 메시지

- pull 방식 : 변경된 데이터가 있는지 요청을 보내 질의하고 변경된 데이터를 가져오는 방식
> * 클라이언트 요청 & 서버 응답 방식의 매플리케이션
> * Java와 같은 절차형 프로그래밍 언어
 

## Reactive Programming에 등장하는 용어정리 (반드시 알아야 하는)

* Observable : 데이터 소스
* 리액티브 연산자(Operators) : 데이터 소스를 처리하는 함수
* 스케쥴러(Scheduler) : 스레드 관리자
* Subscriber : Observable이 발행하는 데이터를 구독하는 구독자
* 함수현 프로그래밍 : RxJava에서 제공하는 연산자(Operator) 함수를 사용

## Reactive Programming (RxJava) 의 기본적인 구조

* 데이터 발행
* 데이터 가공 
* 데이터 구독(처리)

```
Ovservable.just(10,20,30,40,50) //데이터 발행
          .filter(number -> number > 300) //데이터 가공 (데이터 필터링)
          .subscribe(num -> System.out.println(getThreadName() + " : result : " + num));
          //데이터 처리 (발행된 데이터 필터링 데이터를 전달받아 로그로 출력)
```

- 함수 정리

> * `.just()` : `데이터 발행`
> * `.doOnNext()` : 데이터가 발행 될 때 실행되는 함수
> * `.subscribeOn()` : 데이터를 발행하는 쓰레드를 지정
> * `.observeOn()` : 데이터 가공,처리하는 쓰레드를 지정  
> * `.filter()` : `데이터 가공`
> * `.subcribe()` : `데이터 처리`

