---
layout: post
title:  "[Connection] OkHTTP"
subtitle: "connection"
categories: android
tags: android connection library volley http client java
comments: true
---


## 개요
> Volley에 대해 알아보자
  
- 목차
	- [OkHTTP란?](#OkHTTP란?) 
	- [환경설정](#환경설정)
	- [사용방법](#사용방법)
 
## OkHTTP란?
---
`OkHTTP`는 REST API, HTTP 통신을 간편하게 구현할 수 있도록 다양한 기능을 제공해주는 Java 라이브러리다.
OkHttp를 이용하면 간편하게 몇 줄의 코딩으로 REST 호출을 전송, HTTP 기반의 요청, 응답을 처리할 수 있다.

"Square"라는 회사가 만든 OkHttp 라이브러리는 `Retrofit` 이라는 라이브러리의 베이스가 된다. 
[Retrofit 알아보기](https://hm5938.github.io/android/2022/01/17/android-library-connection-retrofit/)

__특징__

* HTTP/2 지원을 통해 동일한 호스트에 대한 모든 요청이 소켓을 공유할 수 있습니다.
* 연결 풀링은 요청 대기 시간을 줄입니다(HTTP/2를 사용할 수 없는 경우).
* 투명 GZIP은 다운로드 크기를 줄입니다.
* 응답 캐싱은 반복 요청에 대해 네트워크를 완전히 피합니다.


## 환경설정
---
`volley`를 사용하기 위해서는 library를 추가해주어야 한다.

build.gradle (Module)
```java
dependencies {
     implementation 'com.squareup.okhttp3:okhttp:3.8.0'
}
```

http통신을 위한 인터넷 허용권한도 필요하다
```java
    <uses-permission android:name="android.permission.INTERNET" />
```

## 사용방법
`okhttp`의 사용방법은 3가지로 구성할 수 있다.

1. [OkHttpClient 생성](#OkHttpClient-생성)
2. [Request 생성](#Request-생성)
3. [실행 후 respose 받기](#실행-후-respose-받기)

### OkHttpClient 생성

```java
  OkHttpClient client = new OkHttpClient.Builder().connectTimeout(60, TimeUnit.SECONDS).readTimeout(60, TimeUnit.SECONDS).build();
```

이때 캐시를 초기화하고 싶으면
```java


        Cache cache = toServer.cache();
        if (cache != null) {
            cache.delete();
            cache.close();
        }
```

### Request 생성

```java
 Request request;
        request = new Request.Builder()
                .url( "해당 URL 입력")
                .cacheControl(new CacheControl.Builder().maxAge(0, TimeUnit.SECONDS).build()).build();
```

### 실행 후 respose 받기

```java
       Response response = client.newCall(request).execute();
        flag = response.isSuccessful();
        
           if (flag) {
            responseBody = response.body().string();

//JSON 형식으로 되어있다면
            JSONObject jsonObject = new JSONObject(responseBody);
        }
```

