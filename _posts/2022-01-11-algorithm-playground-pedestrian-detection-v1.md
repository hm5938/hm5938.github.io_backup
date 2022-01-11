---
layout: post
title:  "[PlayGround] 자이로, 가속도계를 이용한 보행자 감지 시스템"
subtitle: "playground"
categories: algorithm
tags: algorithm playground pedestrian detection

comments: false
---


## 개요
> 자이로, 가속도계를 이용한 보행 감지 시스템 
  
- 목차
	- [자이로센서와 가속도센서?](#자이로센서와-가속도센서?) 
	- [보행자 감지 시스템 개요 (자이로 가속도)](#보행자-감지-시스템-개요-자이로-가속도)
	- [알고리즘](#알고리즘)
	- [코드](#코드)
	- [문제점](#문제점)
	
  
## 자이로센서와 가속도센서?  
---
`Reactive Programming`은 문서 작성을 지원하는 태그(Tag) 형식의 문법이다. 

> __What is Reacrive Programming? (출처 - 위키피디아)__  
> In computing, reactive programming is a `declarative programming` paradigm concerned with `data streams` and `the propagation of change`. 
> = `변화의 전파와 데이터 흐름`과 관련된 `선언적 프로그래밍 패러다임`.
- `변화의 전파와 데이터 흐름` : 데이터가 변경 될 때 마다 이벤트를 발생시켜서 데이터를 계속적으로 전달한다.
- `선언적 프로그래밍 패러다임` : 실행할 동작을 구체적으로 명시하는 명령형 프로그래밍과 달리 선언형 프로그래밍은 단순히 목표를 선언한다.

* __Push 방식과 Pull 방식
- push 방식 : 데이터의 변화가 발생했을 때 변경이 발생한 곳에서 데이터를 보내주는 방식
> * RTC(Real Time Communication)
> * 소켓 프로그래밍
> * DB Trigger
> * Spring 의 ApplicationEvent
> * Angualr의 데이터 바인딩
> * 스마트퐁의 Push 메시지

- pull 방식 : 변경된 데이터가 있는지 요청을 보내 질의하고 변경된 데이터를 가져오는 방식
> * 클라이언트 요청 & 서버 응답 방식의 매플리케이션
> * Java와 같은 절차형 프로그래밍 언어
 

## 보행자 감지 시스템 개요 (자이로 가속도)
![image](https://user-images.githubusercontent.com/48474929/148864421-6e827902-b8b6-4763-a3d4-f5d5bc06c00c.png)


가속도 센서의 theta 값을 이용해 현재 팔을 흔들고 있는지 아닌지 판단 후
흔들고 있다면 자이로&가속도로 판단, 흔들고 있지 않다면 가속도 만으로 보행 감지 판단

fusion(기준값)의 극댓 값과 극솟값으로 보행 감지 판단



## 알고리즘
![image](https://user-images.githubusercontent.com/48474929/148866395-ab095bee-c39b-42be-8deb-3af1696dd9c3.png)

<details>
  <summary>LPF filter</summary>
  
  ![image](https://user-images.githubusercontent.com/48474929/148866718-02d45e45-c919-4bf9-a3a7-322d8c69b48a.png)

</details>

<details>
  <summary>Theta/Phi</summary>
  
  ```
  theta= rad2deg(atan(-lpf.x/sqrt(lpf.z^2+lpf.y^2)));
  phi= rad2deg(atan(lpf.y/sqrt(lpf.z^2+lpf.x^2)));
  
  lpf.x : LPF 통과 된 x 축 가속도
  lpf.y : LPF 통과 된 y 축 가속도
  lpf.z : LPF 통과 된 z 축 가속도
  
  ```
</details>


<details>
  <summary>stabilizing filter</summary>
  
  ```
  //acc
 stb_acc.x = lpf.x*cos(deg2rad(theta))+lpf.y*sin(deg2rad(theta))*sin(deg2rad(phi))+lpf.z*sin(deg2rad(theta))*cos(deg2rad(phi));
stb_acc.y = lpf.y*cos(deg2rad(phi))-lpf.z*sin(deg2rad(phi));
stb_acc.z = lpf.x*sin(deg2rad(theta))*(-1)+lpf.y*cos(deg2rad(theta))*sin(deg2rad(phi))+lpf.z*cos(deg2rad(theta)))*cos(deg2rad(phi));

  lpf.x : LPF 통과 된 x 축 가속도
lpf.y : LPF 통과 된 y 축 가속도
lpf.z : LPF 통과 된 z 축 가속도

  ```
  가속도 센서 뿐만 아니라 자이로 센서 축도 가속도 센서와 같이 안정화 프레임으로 전환 하여야 함
계산 방법은 위 코드에서 아래와 같이 변경하여 대입하면 됨


  ```
lpf.x -> gyro.x로 변경
lpf.y -> gyro.y로 변경
Lpf.z -> gyro.z로 변경
  
stb_gyro.x = gyro.x*cos(deg2rad(theta))+ gyro.y*sin(deg2rad(theta))*sin(deg2rad(phi))+ gyro.z*sin(deg2rad(theta))*cos(deg2rad(phi));
stb_gyro.y = gyro.y*cos(deg2rad(phi))- gyro.z*sin(deg2rad(phi));
stb_gyro.z = gyro.x*sin(deg2rad(theta))*(-1)+ gyro.y*cos(deg2rad(theta))*sin(deg2rad(phi))+ gyro.z*cos(deg2rad(theta))*cos(deg2rad(phi));
  
  ```
</details>

<details>
  <summary>극댓값 검출</summary>
  
  ```
max_value = 0 // 초기값


if (max_value < value){
	max_value = value;
	max_time = time;
}

if(max_value > value+0.5){ // state 변경 조건
	state = 1;
}


  ```
</details>
  
  <details>
  <summary>극솟값 검출</summary>
  
  ```
min_value = 500 // 초기값


if (min_value > value){
	 min_value = value;
	 min_time = time;
}

if(min_value < value-0.5){ // state 변경 조건
	state = 2;
}

  ```
</details>

## 코드

```java
public void StepCount(){
        double fusion;
        if(Math.abs(Math.toDegrees(theta2))>70){
            fusion = stb_acc2.z;
        }else{
            fusion = stb_acc2.z + Math.sqrt(Math.pow(stb_acc2.y,2)+Math.pow(stb_acc2.x,2));
        }
        switch (state){
            case 0:
                /**
                 * fusion의 극댓값 검출 및 시간저장
                 */
                state=isMax(fusion,System.currentTimeMillis());
                break;
            case 1:
                /**
                 * fusion의 극솟값 검출 및 시간저장
                 */
                state = isMin(fusion,System.currentTimeMillis());
                time_diff = min_time - max_time;
                if(time_diff>=3000){
                    state=0;
                    step =0;
                    min_value=500;
                    max_value=0;
                }else state=2;
                break;
            case 2:
                double degree= (max_value-min_value)/(-1*time_diff*MS2S);
                double area = (max_value-min_value)*time_diff*MS2S;
                if(degree<=-0.4&&Math.abs(area)>=0.5){
                    if(min_time-step_time>2000){
                        state=0;
                        step=1;
                        min_value=500;
                        max_value=0;
                        step_time=min_time;
                         /**
                 * 보행감지
                 */
                    } else{
                        if(min_time-step_time<300){
                            state=0;
                            min_value=500;
                            max_value=0;
                        }else
                            {
                            state=0;
                            step++;
                            min_value=500;
                            max_value=0;
                            step_time=min_time;
                            /**
                 * 보행감지
                 */
                        }
                    }
                }else {
                    state =0;
                    min_value=500;
                    max_value=0;
                }

                if(step>=3){
                  /**
                 * 보행자 판단
                 */
                }

        }
    }
```

## 문제점
    
![image](https://user-images.githubusercontent.com/48474929/148868128-6e3e1459-ae6e-43ca-93aa-10e844726b45.png)
    
 화면을 보며 보행할 시 감지가 되지 않는 현상 발생 개선 방안 필요
