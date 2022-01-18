---
layout: post
title:  "[Asynchronous] AsyncTask"
subtitle: "asynchronous"
categories: android
tags: android asynchronous asyncTask

comments: false
---


## 개요
> AsynTask
  
- 목차
  - [AsynTask란 무엇일까](#AsynTask란-무엇일까)
  - [사용법](#사용법)
  - [제약조건](#제약조건)
  - [장단점](#장단점)
  - [대체 방식](#대체-방식)
	
  
## AsynTask란 무엇일까

---
`AsynTask`은 비동기 작업을 도와주는 클래스로 Android API level 30에서 desperated 되었다.

> UI 스레드에 직접 접근할 수 있다.
> 
> 핸들러, 루프 패턴보다 코드가 간결하다.


## 사용법

```java
 private class DownloadFilesTask extends AsyncTask<URL, Integer, Long> {
     protected Long doInBackground(URL... urls) {
         int count = urls.length;
         long totalSize = 0;
         for (int i = 0; i < count; i++) {
             totalSize += Downloader.downloadFile(urls[i]);
             publishProgress((int) ((i / (float) count) * 100));
             // Escape early if cancel() is called
             if (isCancelled()) break;
         }
         return totalSize;
     }

     protected void onProgressUpdate(Integer... progress) {
         setProgressPercent(progress[0]);
     }

     protected void onPostExecute(Long result) {
         showDialog("Downloaded " + result + " bytes");
     }
 }
       
```



## 제약조건
 * API16(젤리빈) 미만 버전에서는 AsyncTask 선언을 UI Thread에서 해주지 않으면 오류가 발생한다. (API 16 이상(JELLY BEAN)의 버전에서는 자유롭게 사용해도 된다고합니다.)
 * excutes(Params)는 UI 스레드에서 직접호출해야합니다
 * 수동으로 onPreExecute(), onPostExecute(Result), doInBackground(Params...), onProgressUpdate(Progress...) 호출하면 안됩니다.
 * Task는 오직 한번만 실행될 수 있습니다.


## 장단점

[장점]
* 코드의 가독성 뛰어남
* UI Thread 에 직접 접근할 수 있다

[단점]
* 오직 한 번만 실행되어 재사용이 불가능
* 종료를 직접 해주지 않으면 종료가 되지 않아 메모리 누수가 발생
* 항상 UI 쓰레드 상에서 호출

[시스템 결함]
* 메모리 릭
화면이 회전할 때 액티비티는 종료되었다가 새롭게 생성된다. 이 경우 AsyncTask 가 계속 중첩되어 실행될 수가 있다. 새로 생성된 액티비티는 완전히 다른 인스턴스인데, AsyncTask 가 실행되고 있던 와중에 화면 회전이 일어난 거라면 기존 액티비티조차 메모리에서 해제되지 않는다. 이는 OutOfMemory 에러를 뿜을 가능성이 농후하다.
* 순차적으로 실행되기 때문에 속도가 저하될 수 있다.
* Fragment 에서 AsyncTask 를 실행할 경우
Fragment 에서 AsyncTask 를 실행하고 뒤로가기 키를 통해 액티비티를 종료하면, Fragment 가 Activity 와 분리되면서 getContext(), getActivity() 등이 null 을 반환하게 되어 onPostExecute() 에서 NullPointerException 이 발생하게 된다.
* 취소 메소드만 있고, 예외처리 메소드가 없다
* AsyncTask 병렬 실행 시 doInBackground() 의 실행순서가 보장되지 않음
안드로이드 버전이 올라가면서, 기본 동작이 순차 실행으로 바뀌었기 때문에 플랫폼의 버전에 따라 일관되지 않은 동작을 야기할 수 있는 점이 문제다.

## 대체 방식

`Rxjava`
`Coroutine`

