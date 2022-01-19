---
layout: post
title:  "[RxJava] Operators"
subtitle: "rxjava"
categories: android
tags: android rxjava rxandroid operators
comments: true
---


## 개요
> Observable의 연산자들을 기능별로 알아본다
  
- 목차
	- [Type of Operators](#type-of-operators) 
	- [Create Operators](#create-operators)
	- [Filter Operators](#filter-operators)
	- [Transfomation Operators](#transformation-operators)
	
 
## Type of Operators
---
생성, 검색, 변환의 기능에 따른 연산자를 알아보자

__Observable 생성__

> reate(), fromIterable(), fromArray(), just(), range(). repeat()

__Filtering & Sorting__

> filter(), distinct(), take(). takeLast(). skip()

__다른유형으로 변환__

> map(), flatMap(), switchMap(), buffer(), concatMap()

## Create Operators
---
from 연산자에 대하여 알아보자
> subscribe 와 함께 메서드를 실행합니다.

__fromArray()__
> 객체 배열을 입력하고, Observable을 출력한다.

__fromIterable()__
> 객체의 iterable을 입력하고, Observable을 출력한다.
> 가능한 유형: List, ArrayList, Set 등

[__fromCallable()__](https://hm5938.github.io/android/2022/01/20/android-rxjava-fromcallable/)
> 코드블록(메서드)를 실행하고 결과를 반환한다.

## Filter Operators

## Transfomation Operators
