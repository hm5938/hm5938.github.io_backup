---
layout: post
title:  "[RxJava] RxAndroid 환경구축"
subtitle: "rxjava"
categories: android
tags: android rxjava rxandroid  
comments: false
---


## 개요
> RxAndroid에 대해 알라보고, Android Studio에서 RxAndroid를 사용하는 방법에 대해 알아본다.
  
- 목차
	- [RxAndroid란?](#rxandroid란) 
	- [프로젝트 환경구축](#프로젝트-환경구축)
	- [일부분만 정렬](#일부분만-정렬)
	- [객체 배열 정렬](#객체-배열-정렬)
	
 
## RxAndroid란?
---
RxAndroid란? 지금까지 공부한 ReactiveX 관련 기능을 Android App에서 쉽고 간견하게 사용할 수 있는 라이브러리를 말합니다.

 

그럼 왜 RxAndroid를 사용해야 할까요?

 

지금까지 Android 개발에서 제일 큰 어려움은 아마 thread 사용에 있을 것입니다.

1. 안ㄴ드로이드 비동기 처리 및 에러 핸들링.

2. 수많은 핸들러와 콜백 때문에 발생하는 디버깅 문제

3. 2개의 비동기 처리 후 결과 합성

4. 이벤트 중복 실행 

 

등 이외에도 다양한 어려움이 있었을 것입니다.

하지만 RxAndroid 사용함으로서 다음과 같은 장점을 얻을 수 있습니다.

1. 간단한 코드로 복잡한 병행 프로그래밍을 할 수 있습니다.

2. 비동기 구조에서 에러를 다루기 쉽습니다.

3. 함수형 프로그래밍 기법도 부분적으로 적용할 수 있습니다.

 

이런 RxAndroid의 API는 [여기](https://github.com/Reactivex/Rxandroid/wiki)서 확인 하실 수 있습니다.

간단하게

RxLifecycle은 RxJava를 사용하는 안드로이드 앱용 라이프 사이클 처리 API

RxBinding은 안드로이드 UI 위젯용 RxJava 바인딩 API

RxPermissions는 RxJava에서 제공하는 안드로이드 런타임 권한 라이브러리 입니다.

이 외에도 다양한 api가 존재하니 꼭 API를 확인하면 좋을것 같습니다.


## 프로젝트 환경구축
프로젝트를 생성 후 build.gradle에 다음을 추가합니다.(Project gradle이 아닌 Moudle:app gradle에 추가합니다.)

```java
//RxAndroid와 RxJava , RxKotlin 추가
    implementation 'io.reactivex.rxjava2:rxandroid:2.1.1'
    implementation 'io.reactivex.rxjava2:rxjava:2.2.17'
    implementation 'io.reactivex.rxjava2:rxkotlin:2.4.0'
// 필요한 API를 찾아서 추가 합니다.
     implementation 'com.jakewharton.rxbinding3:rxbinding:3.1.0'
    implementation 'com.uniquext.android:rxlifecycle:2.0.0'
```
```