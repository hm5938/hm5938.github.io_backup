---
layout: post
title:  "[PlayGround] 자이로, 가속도계를 이용한 보행자 감지 시스템 v2"
subtitle: "playground"
categories: algorithm
tags: algorithm playground pedestrian detection

comments: false
---


## 개요
> 자이로, 가속도계를 이용한 보행 감지 시스템 (버전2)
  
- 목차
	- [기존 문제점과 해결방안](#기존-문제점과-해결방안) 
	- [보행자 감지 시스템 개요 (자이로 가속도)](#보행자-감지-시스템-개요-자이로-가속도)
	- [자이로 알고리즘 (팔을 흔들 때)](#자이로-알고리즘-팔을-흔들-때)
	- [자이로 코드](#자이로-코드)
	- [가속도 알고리즘](#가속도-알고리즘)
	- [가속도 코드](#가속도-코드)
	- [결과](#결과)
	
  
## 기존 문제점과 해결방안 
---
![image](https://user-images.githubusercontent.com/48474929/148868128-6e3e1459-ae6e-43ca-93aa-10e844726b45.png)
    
 화면을 보며 보행할 시 감지가 되지 않는 현상 발생 개선 방안 필요
 
 -> 가속도와 자이로를 따로 검출하는 방안 적용
 
 자이로센서 검출 개념
 ![image](https://user-images.githubusercontent.com/48474929/148870084-8956c180-af4b-43b6-bc17-b4bbbe19b2d6.png)

 ![image](https://user-images.githubusercontent.com/48474929/148870101-9336606e-ba51-4dd2-9ce0-e5890e755c3f.png)


>  가속도센서 검출 방식
차량 주행 상태를 제외하기 위하여 약간 둔감하게 반응 함

ex> 실제걸음 13걸음 시 11~12걸음 검출
차량 정지 상태에서는 검출이 일어나지 않음
수정 적용 방식으로 차량 주행 상태 시 보행모드 전환이 거의 되지 않으나 총 주행상태 실험(약 1분 30초) 3개의 Case에서 1개의 Case에서 3걸음 연속  검출이 일어나서 보행모드 판단을 2차로 분리함

> 자이로센서
안정화 프레임에서의 y, x 축에 걸음 성분이 따로 나타나 지며 x축 보다 y축이 더욱 뚜렷하게 나타남
자이로의 y축을 제곱하여 2걸음 파형을 1걸음 파형으로 바꿔서 검출


## 보행자 감지 시스템 개요 (자이로 가속도)
![image](https://user-images.githubusercontent.com/48474929/148870390-64426298-f155-4f89-9b36-6f54d76f48a6.png)


## 자이로 알고리즘 (팔을 흔들 때)
![image](https://user-images.githubusercontent.com/48474929/148866395-ab095bee-c39b-42be-8deb-3af1696dd9c3.png)

<details>
  <summary>LPF filter</summary>
  
 ![image](https://user-images.githubusercontent.com/48474929/148870910-b915d798-a29b-4fdf-afb3-df60f0390805.png)

</details>

<details>
  <summary>stabilizing filter</summary>
  
  ```
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

if(max_value > value+0.3){ // state 변경 조건
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

if(min_value < value-0.3){ // state 변경 조건
	state = 2;
}

  ```
</details>

  
## 자이로 코드

```java
  public void StepCount4G() {
            double fusion;
            fusion = Math.pow(stb_gyro2.y, 2);
            switch (state) {
                case 0:
                    /**
                     * fusion의 극댓값 검출 및 시간저장
                     */
                    state = isMax(fusion, System.currentTimeMillis());
                    break;
                case 1:
                    /**
                     * fusion의 극솟값 검출 및 시간저장
                     */
                    state = isMin(fusion, System.currentTimeMillis());
                    time_diff = min_time - max_time;
                    if (time_diff >= 3000) {
                        state = 0;
                        step = 0;
                        min_value = 500;
                        max_value = 0;
                    } else state = 2;
                    break;
                case 2:
                    double degree = (max_value - min_value) / (-1 * time_diff * MS2S);
                    double area = (max_value - min_value) * time_diff * MS2S;
                    Log.d("RESULT_STEPCOUNTER", "max:" + max_value + "min : " + min_value + "degree : " + degree + " area : " + area);
                    if (degree <= -0.3 && Math.abs(area) >= 0.4) {
                        if (min_time - gyro_step_time > 2000) {
                            state = 0;
                            step = 1;
                            min_value = 500;
                            max_value = 0;
                            gyro_step_time = min_time;
                            Toast.makeText(parent, "gyrostep:" + step + "\n" + (gyro_step_time - acc_step_time), Toast.LENGTH_SHORT).show();
                        } else {
                            if (min_time - gyro_step_time < 300) {
                                state = 0;
                                min_value = 500;
                                max_value = 0;
                            } else {
                                state = 0;
                                step++;
                                min_value = 500;
                                max_value = 0;
                                gyro_step_time = min_time;
                                Toast.makeText(parent, "gyrostep:" + step + "\n" + (gyro_step_time - acc_step_time), Toast.LENGTH_SHORT).show();
                            }
                        }
                    } else {
                        state = 0;
                        min_value = 500;
                        max_value = 0;
                    }

                    if (step >= 5) {
                        isgyroStep = true;
                        presenter.setMode(MODE_PEDESTRAIN);
                    }

            }
            Log.d("RESULT_STEPCOUNTER", "state : " + state + " step : " + step + " min :" + min_value + " max :" + max_value + " theta2 : " + Math.toDegrees(theta2) + " fusion : " + fusion);

            if (step < 4) {
                isgyroStep = false;
            }

        }
```

                         
## 가속도 알고리즘
![image](https://user-images.githubusercontent.com/48474929/148870466-7d9bc1be-c860-484b-9d38-9f541a83934e.png)

<details>
  <summary>LPF filter</summary>
  
  ![image](https://user-images.githubusercontent.com/48474929/148870508-c22a0f2c-0b04-4b37-9059-158420758d71.png)
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
</details>

<details>
  <summary>극댓값 검출</summary>
  
  ```
max_value = 0 // 초기값


if (max_value < value){
	max_value = value;
	max_time = time;
}

if(max_value > value+0.7){ // state 변경 조건
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

if(min_value < value-0.7){ // state 변경 조건
	state = 2;
}


  ```
</details>

    
    
## 가속도 코드

```java
 public void StepCount4A() {
            double fusion;
            fusion = stb_acc2.z;

            switch (state) {
                case 0:
                    /**
                     * fusion의 극댓값 검출 및 시간저장
                     */
                    state = isMax(fusion, System.currentTimeMillis());
                    break;
                case 1:
                    /**
                     * fusion의 극솟값 검출 및 시간저장
                     */
                    state = isMin(fusion, System.currentTimeMillis());
                    time_diff = min_time - max_time;
                    if (time_diff >= 3000) {
                        state = 0;
                        step = 0;
                        min_value = 500;
                        max_value = 0;
                    } else state = 2;
                    break;
                case 2:
                    double degree = (max_value - min_value) / (-1 * time_diff * MS2S);
                    double area = (max_value - min_value) * time_diff * MS2S;
                    Log.d("RESULT_STEPCOUNTER", "max:" + max_value + "min : " + min_value + "degree : " + degree + " area : " + area);
                    if (degree <= -0.1 && Math.abs(area) >= 0.2 && degree > -15 && Math.abs(area) < 6) {
                        if (min_time - acc_step_time > 2000) {
                            state = 0;
                            step = 1;
                            min_value = 500;
                            max_value = 0;
                            acc_step_time = min_time;
                            Toast.makeText(parent, "accstep:" + step + "\n" + (acc_step_time - gyro_step_time), Toast.LENGTH_SHORT).show();
                        } else {
                            if (min_time - acc_step_time < 300) {
                                state = 0;
                                min_value = 500;
                                max_value = 0;
                            } else {
                                state = 0;
                                step++;
                                min_value = 500;
                                max_value = 0;
                                acc_step_time = min_time;
                                Toast.makeText(parent, "accstep:" + step + "\n" + (acc_step_time - gyro_step_time), Toast.LENGTH_SHORT).show();
                            }
                        }
                    } else {
                        state = 0;
                        min_value = 500;
                        max_value = 0;
                    }

                    if (step >= 5) {
                        isaccStep = true;
                        presenter.setMode(MODE_PEDESTRAIN);
                    }

            }
            Log.d("RESULT_STEPCOUNTER", "state : " + state + " step : " + step + " min :" + min_value + " max :" + max_value + " theta2 : " + Math.toDegrees(theta2) + " fusion : " + fusion);
            if (step < 4) {
                isaccStep = false;
            }
        }

```
  
    
