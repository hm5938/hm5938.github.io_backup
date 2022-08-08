---
layout: post
title:  "[Xml] Vector"
subtitle: "xml"
categories: android
tags: android xml vector path sgv
comments: false
---

## 개요
> `vector`이미지 알아보기

- 목차
	- [vector 이미지 생성](#vector-이미지-생성) 
	- [속성](#속성)
	- [환경 구축](#환경-구축)

## vector 이미지 생성
android에서 vector 이미지를 생성하는 방법에는 두가지가 있다.

1. [직접 벡터 이미지 생성](#직접-벡터-이미지-생성) 
	
2. [svg 파일을 벡터이미지로 변환](#svg-파일을-벡터이미지로-변환) 


### 직접 벡터 이미지 생성
drawable> 오른쪽마우스 클릭 > New/Drawable Resource File > root element에 vector 적고 OK

생성후 속성과 path를 추가해준다

### svg 파일을 벡터이미지로 변환

drawable > 오른쪽마우스클릭 > Vector Asset > 경로, 이름 설정후 Next > Finish

## 속성
`vector`

* android:width
* android:height
* android:viewportWidth
* android:viewportHeight
* android:alpha
  
`path`

* android:pathData
* android:fillColor
* android:strokeColor
* android:strokeWidth
* android:strokeAlpha
* android:fillAlpha
* android:strokeLineCap
* android:strokeLineJoin
* android:strokeMiterLimit

`group`

* android:rotation
* android:pivotX
* android:pivotY
* android:scaleX
* android:scaleY
* android:translateX
* android:translateY


```xml
    android:width="56.69dp"
    android:height="56.69dp"
    android:viewportWidth="56.69"
    android:viewportHeight="56.69"
```
```xml
  <path
      android:pathData="M42.89,19.38l-12.29,-7.1v4.25h-3.84c-7.14,0 -12.95,5.81 -12.95,12.95V44.4h5.69V29.49c0,-4 3.26,-7.26 7.26,-7.26h3.84v4.25L42.89,19.38z"
      android:fillColor="#6E6E6E"/>
```
## 환경 구축

```java
android {
    defaultConfig {
        vectorDrawables.useSupportLibrary = true
    }
}

dependencies {
    implementation 'com.android.support:appcompat-v7:23.2.0'
}
```
