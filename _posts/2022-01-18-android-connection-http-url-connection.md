---
layout: post
title:  "[Connection] HttpUrlConnection"
subtitle: "connection"
categories: android
tags: android connection httpurlconnection http

comments: false
---


## 개요
> HttpUrlConnection
  
- 목차
	- [HttpUrlConnection이란 무엇일까](#HttpUrlConnection이란-무엇일까) 
	- [환경구축](#환경구축)
	- [사용법](#사용법)
	
  
## HttpUrlConnection이란 무엇일까
---
`HttpUrlConnection`은 Android 및 Java용 HTTP 클라이언트 입니다.

> java.net에 포함된 클래스로 별도의 라이브러리 추가가 필요 없다.
> 자신이 원하는 방식으로 커스텀하여 사용할 수 있다.


## 환경구축
HTTPURLConnection은 별도의 라이브러리를 추가하지 않아도 되므로
인터넷 허용 권한만 주면 사용할 수 있습니다.

```java
<uses-permission android:name="android.permission.INTERNET"></uses-permission>
```

Https 가 아닌 http를 사용할 시
```java
android:usesCleartextTraffic="true"
```
를 추가해주어야 합니다.

## 사용법

```java
 URL url = null;
 String content = "";
        try {
            url = new URL("https://httpurlconnectionexample.co.kr/" +
                    content +
                    "?id=20");

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            // 통신이 성공했을 경우
            if (conn.getResponseCode() == conn.HTTP_OK) {
                InputStreamReader tmp = new InputStreamReader(conn.getInputStream(), "UTF-8");
                BufferedReader reader = new BufferedReader(tmp);
                StringBuffer buffer = new StringBuffer();
                while ((str = reader.readLine()) != null) {
                    buffer.append(str);
                }
                receiveMsg = buffer.toString();
                Log.i("receiveMsg : ", receiveMsg);

                reader.close();
            } else {
                Log.i("통신 결과", conn.getResponseCode() + "에러");
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
       
```
