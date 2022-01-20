---
layout: post
title:  "[Connection] 간단하고 Http 통신을 위한 - Volley"
subtitle: "connection"
categories: android
tags: android connection library volley http client java
comments: true
---


## 개요
> Volley에 대해 알아보자
  
- 목차
	- [Volley란?](#Volley란?) 
	- [환경설정](#환경설정)
	- [사용방법](#사용방법)
 
## Volley란?
---
`Volley`는 Android 앱의 네트워킹을 더 쉽고, 무엇보다도 더 빠르게 하는 HTTP 라이브러리입니다.

__특징__

* 네트워크 요청의 자동 예약.
* 여러 개의 동시 네트워크 연결
* 표준 HTTP 캐시 일관성을 갖춘 투명한 디스크 및 메모리 응답 캐싱
* 요청 우선순위 지정 지원
* 취소 요청 API. 단일 요청을 취소하거나 취소할 요청의 블록 또는 범위를 설정할 수 있습니다.
* 용이한 맞춤설정(예: 재시도, 백오프)
* 강력한 정렬 기능을 이용하여 네트워크에서 비동기식으로 가져온 데이터로 UI를 올바로 채우는 작업을 쉽게 실행할 수 있음.
* 디버깅 및 추적 도구.


## 환경설정
---
`volley`를 사용하기 위해서는 library를 추가해주어야 한다.

build.gradle (Module)
```java
dependencies {
    implementation 'com.android.volley:volley:1.1.0'
}
```

http통신을 위한 인터넷 허용권한도 필요하다
```java
    <uses-permission android:name="android.permission.INTERNET" />
```

## 사용방법
`volley`의 사용방법 3가지로 구성할 수 있다.

1. 먼저 Request class 를 생성해준다
2. Response listener 생성
3. http 요청

Request.class
```java
public class VolleyRequest extends StringRequest {
    final static private String URL = "요청할  url";
    private Map<String, String> parameters;
    public VolleyRequest(String id, Response.Listener<String> listener) {
        super(Method.POST, URL, listener, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("RegisterRequest", error.getMessage());
            }
        });
        parameters = new HashMap<>();
        parameters.put("id", id);
    }
    @Override
    public Map<String, String> getParams() {
        return parameters;
    }
}

```

respose listener
```java
        Response.Listener<String> responseListener = new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                try {
                    JSONObject jsonResponse = new JSONObject(response);
                    boolean isSuccess = jsonResponse.getBoolean("success");
                    if (isSuccess) {

                    } else {

                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        };


```

실행코드
```java
        VolleyRequest volleyRequest = new VolleyRequest(" ", responseListener);
        RequestQueue requestQueue = Volley.newRequestQueue(MainActivity.this);
        requestQueue.add(volleyRequest);
```


