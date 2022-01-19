---
layout: post
title:  "[Java] 화면 켜짐 유지"
subtitle: "java"
categories: android
tags: android java function keep screen on off flag

comments: false
---


## 개요
> 어플리케이션 화면 켜짐 유지
  
- 목차
  - [화면켜짐유지](#화면켜짐유지)
  - [화면켜짐유지해제](#화면켜짐유지해제)
  - [코드](#코드)
	
  
## 화면켜짐유지

```java
getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
```

## 화면켜짐유지해제

```java
getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
```

## 코드

```java
public void screenOnOff(boolean iskeep){
        if(iskeep){
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        }else{
            getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        }
    }
       
```
