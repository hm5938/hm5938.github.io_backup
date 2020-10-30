---
layout: post
title:  "[RxJava] CompositeDisposable"
subtitle: "rxjava"
categories: android
tags: android rxjava compositedisposable
comments: false
---


## 개요
> CompositeDisposable
  
- 목차
	- [CompositeDisposable](#compositedisposable) 
	- [Flowable](#flowable)
	- [Observable to Flowable](#observable-to-flowable)
	- [둘중 어느것을 사용할까?](#둘중-어느것을-사용할까)
	
 
## CompositeDisposable
---
Observing을 계속하면 메모리 누수가 생기기 때문에 데이터의 구독을 시작하면서 compositeDosposable에 추가하고,
Observing을 그만두게 될 때(뷰모델이 사라질 때 == 뷰가 사라질 때) compositeDisposable을 비워줌으로서 메모리 누수를 방지하는 작업이다.

__생성__
```java
CompositeDisposable disposables = new CompositeDisposable();
```

__사용__
```java
@Override
public void onSubscribe(Disposable d) {
    disposables.add(d);
}
```
전체코드를 보면 ,
```java
 taskObservable.subscribe(new Observer<Task>() {
            @Override
            public void onSubscribe(Disposable d) {
                Log.d(TAG, "onSubcribe: called.");
                disposables.add(d);
            }

            @Override
            public void onNext(Task task) {
                Log.d(TAG,"onNext: "+ Thread.currentThread().getName());
                Log.d(TAG,"onNext: "+ task.getDescription());


            }

            @Override
            public void onError(Throwable e) {
                Log.e(TAG,"onError: "+e);

            }

            @Override
            public void onComplete() {
                Log.d(TAG,"onComplete: called.");

            }
        });
```
* 이렇게도 사용할 수 있다!
```java
disposables.add(taskObservable.subscribe(new Consumer<Task>() {
            @Override
            public void accept(Task task) throws Exception {

            }
        }));
```



__삭제__
Observer의 사용이 끝났다면 disposable을 지워줘야한다. 만약 Activity나 Fragment안에 있다면 onDestroy() 안에 만들어주면 되고, ViewModel안에 생성할 때는 onCleared() 안에 다음 코드를 넣어주면 된다. 
```java
disposables.clear();
```
