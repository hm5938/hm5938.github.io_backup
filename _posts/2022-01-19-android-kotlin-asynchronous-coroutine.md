---
layout: post
title:  "[Kotlin] Coroutine"
subtitle: "kotlin"
categories: android
tags: android kotlin asynchronous coroutine

comments: false
---


## 개요
> Coroutine
  
- 목차
  - [Coroutine이란 무엇일까](#Coroutine이란-무엇일까)
  - [환경설정](#환경설정)
  - [사용법](#사용법)
	
  
## Coroutine이란 무엇일까

---
`Coroutine`은 비동기적으로 실행되는 코드를 간소화하기 위해 Android에서 사용할 수 있는 동시 실행 설계 패턴입니다.

> 코루틴(coroutine)은 루틴의 일종으로서, 협동 루틴이라 할 수 있다
>(코루틴의 "Co"는 with 또는 togather를 뜻한다). 
>상호 연계 프로그램을 일컫는다고도 표현가능하다. 
>루틴과 서브 루틴은 서로 비대칭적인 관계이지만, 코루틴들은 완전히 대칭적인, 즉 서로가 서로를 호출하는 관계이다. 
>코루틴들에서는 무엇이 무엇의 서브루틴인지를 구분하는 것이 불가능하다. 코루틴 A와 B가 있다고 할 때, A를 프로그래밍 할 때는 B를 A의 서브루틴으로 생각한다. 
>그러나 B를 프로그래밍할 때는 A가 B의 서브루틴이라고 생각한다. 
>어떠한 코루틴이 발동될 때마다 해당 코루틴은 이전에 자신의 실행이 마지막으로 중단되었던 지점 다음의 장소에서 실행을 재개한다.
> 
> 

## 환경설정

build.gradle

```java
dependencies {
    implementation 'org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.9'
}
```

## 사용법

```java
     private val job = Job()
        CoroutineScope(Dispatchers.Main).launch {
        
            val job1 = launch { Test1() }
            val job2 = launch { Test2() }
            
            job1.join()
            job2.join() 
            //job1과 job2 동시 실행
            
            
            var asynctest = async(Dispatchers.Default + job) {
              Test()
            }.await()
            
            
        }
       
```

* `CoroutineScope` 하나 이상의 관련 coroutine을 관리
* `Dispatchers.` 이 코루틴을 어떤 스레드에서 실행할 것인지 예약 ( 예를 들어 Dispatchers.Main 이면 메인 스레드, Dispatcher.IO 면 I/O 작업용 스레드 )

* `launch` 코루틴을 만들고 실행을 `dispatcher`에 전달하는 함수, `job`을 리턴
* `join` join 한 코루틴을 동시에 실행

* `async` 코루틴을 만들고 실행, `deferred`를 리턴
* `await` deferred값이 계산될 때까지 기다린 후 리턴

