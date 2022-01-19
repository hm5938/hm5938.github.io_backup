---
layout: post
title:  "[RxJava] Rxjava로 비동기 작업하기 - fromCallable()"
subtitle: "rxjava"
categories: android
tags: android rxjava fromcallable asynchronous
comments: false
---


## 개요
> Rxjava로 백그라운드 스레트에서 메서드를 실행하는 방법에 대해 알아보겠습니다
  
- 목차
	- [들어가기 전](#들어가기-전)
  - [fromCallable()](#fromCallable)
 
## 들어가기 전
---
본격적으로 fromCallable에 대해 알아보기 전에 먼저 rxJava에 대한 기본적인 이해가 필요합니다.
만약 잘 모른다면 아래를 클릭하여 먼저 알아본 후 진행하세요

* [__[RxJava] RxJava 알아보기 - 리액티브 프로그래밍(Reactive Programming)이란?__](https://hm5938.github.io/android/2020/10/23/android-rxjava-intro-reactive-programming-md/)
* [__[RxJava] RxAndroid 환경구축__](https://hm5938.github.io/android/2020/10/28/android-rxjava-rxandroid-setting-md/)
* [__[RxJava] Operators에 대해 알고싶다면?__](https://hm5938.github.io/android/2020/10/30/android-rxjava-operators-md/#create-operators)

## fromCallable()
---
fromCallable() 은 메서드를 실행하고 결과를 반환하는 함수로
subscribe 된 후에만 메서드를 실행한다는 특징이 있습니다.

백그라운드 스레드에서 해당 작업을 수행한 후 메인 스레드로 반환할 수 있습니다.
  
  
  예를 들면
  ```java
  // Observable 생성 (아직 실행 전)
Observable<Task> callable = Observable
        .fromCallable(new Callable<Task>() {
            @Override
            public Task call() throws Exception {
                return Test.getTask();
            }
        })
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread());

// subscribe 후 실행
callable.subscribe(new Observer<Task>() {
    @Override
    public void onSubscribe(Disposable d) {

    }

    @Override
    public void onNext(Task task) {
        Log.d(TAG, "onNext: : " + task.getDescription());
    }

    @Override
    public void onError(Throwable e) {

    }

    @Override
    public void onComplete() {

    }
});
  
  ```
  
  생성과 동시에 바로 실행시키고 싶다면
  
  ```java
  Disposable callable;
          callable = Observable.fromCallable(() -> {
            return Test.getTask();
        })
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe((result) -> {
               
                    //결과
                    callable.dispose();
                });
  ```
  
