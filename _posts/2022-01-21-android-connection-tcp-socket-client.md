---
layout: post
title:  "[Connection] Socket으로 TCP 통신을 해보자 - TCP Client"
subtitle: "connection"
categories: android
tags: android connection tcp socket client java
comments: true
---


## 개요
> Socket 을 통해 TCP 통신 하는 방법을 알아보자
  
- 목차
	- [Socket과 TCP](#Socket과-TCP) 
	- [환경설정](#환경설정)
	- [사용방법](#사용방법)
 
## Socket과 TCP
---
`TCP`는 TCP는 두 프로그램 간 통신이 처음 시작될 때부터 끝날때까지 계속 연결을 유지하는 연결지향(Connection oriented) 방식이다.

__특징__

* 스트림 소켓 방식
* 양쪽 어플리케이션이 모두 데이터를 주고 받기가 가능하다.
* 흐름 제어 등을 보장해주며 송신된 순서에 따른 중복되지 않은 데이터 수신 가능하다.
* IP와 포트 번호로 소켓을 연결하면 통신이 시작된다.
* byte 자료형으로 데이터를 보낸다.

`Socket`은 두 프로그램이 네트워크를 통해 서로 통신을 수행 할 수 있도록 양쪽에 생성되는 링크의 단자이다.

__특징__

* 데이터를 캡슐화하여 전달 가능하다.
* UNIX에서의 입출력 메소드의 표준인 개발/읽기/쓰기/닫기 메커니즘이다.

## 환경설정
---

tcp통신을 위해서는 인터넷 허용권한이 필요하다
```java
    <uses-permission android:name="android.permission.INTERNET" />
```

## 사용방법

1. [소켓 생성과 서버 접속](#소켓-생성과-서버-접속)
2. [서버에 데이터 전송](#서버에-데이터-전송)
3. [서버에서 데이터 받기](#서버에서-데이터-받기)

이 세가지 절차는 모두 thread안에 존재하여야 하며 예외처리 또한 해야 작동된다.

[예외처리 바로가기](#예외처리)

### 소켓 생성과 서버 접속

```java
  Socket socket;
              InetAddress serverAddr = InetAddress.getByName(IP);

            socket = new Socket(serverAddr, PORT);
  
```

### 서버에 데이터 전송

```java
                PrintWriter out = new PrintWriter(new BufferedWriter
                        (new OutputStreamWriter(socket.getOutputStream())), true);
                                        out.println("요청할 때 전달할 String");
```

### 서버에서 데이터 받기

```java
     InputStream in =  socket.getInputStream();
              in.read(); //데이터 읽기
```

### 예외처리
```java
try { //클라이언트 소켓 생성
 
  Socket socket = new Socket(IP, PORT);
  
}  catch (UnknownHostException uhe) {
// 소켓 생성 시 전달되는 호스의 IP를 식별할 수 없음.
 
  Log.e(TAG," 생성 Error : 호스트의 IP 주소를 식별할 수 없음.(잘못된 주소 
  값 또는 호스트 이름 사용)");
  
} catch (IOException ioe) { 
// 소켓 생성 과정에서 I/O 에러 발생. 주로 네트워크 응답 없음.
 
  Log.e(TAG," 생성 Error : 네트워크 응답 없음");
 
} catch (SecurityException se) { 
// security manager에서 허용되지 않은 기능 수행.
 
  Log.e(TAG," 생성 Error : 보안(Security) 위반에 대해 보안 관리자(Security Manager)에 
  의해 발생. (프록시(proxy) 접속 거부, 허용되지 않은 함수 호출)");
  
} catch (IllegalArgumentException le) {
// 소켓 생성 시 전달되는 포트 번호(65536)이 허용 범위(0~65535)를 벗어남.
 
  Log.e(TAG," 생성 Error : 메서드에 잘못된 파라미터가 전달되는 경우 발생.
  (0~65535 범위 밖의 포트 번호 사용, null 프록시(proxy) 전달)");
  
 }

```
