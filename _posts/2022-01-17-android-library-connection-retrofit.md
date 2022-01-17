---
layout: post
title:  "[Connection] Retrofit"
subtitle: "connection"
categories: android
tags: android library connection retrofit http

comments: false
---


## 개요
> Retrofit
  
- 목차
	- [Retrofit이란 무엇일까](#Retrofit이란-무엇일까) 
	- [환경구축](#환경구축)
	- [data class 생성 (JSON만 해당)](#data-class-생성-JSON만-해당)
	- [Interface 정의](#Interface-정의)
	- [사용법](#사용법)
	
  
## Retrofit이란 무엇일까
---
`Retrofit`은 Android 및 Java용 HTTP 클라이언트 입니다.

> Retrofit 은 서버와 클라이언트 간 http 통신을 위한 라이브러리입니다.
> 보통 안드로이드에서 http통신을 할 때 사용합니다.

## 환경구축

build.gradle(Module) 에 Retrofit라이브러리와 Gson변환기 라이브러리를 추가시켜줍니다.
여기서 Gson 변환기는 Retrofit으로 통신한 결과값이 json형식일 때 형식 변환을 도와주는 converter 역할을 하게 됩니다.

```java
dependencies {
    // Retrofit 라이브러리
    implementation 'com.squareup.retrofit2:retrofit:2.6.4'
    // Gson 변환기 라이브러리
    implementation 'com.squareup.retrofit2:converter-gson:2.6.4'
}
```

AndroidMeanifest.xml

```java
 <uses-permission android:name="android.permission.INTERNET"/>
 
 <application
    ...
    android:usesCleartextTraffic="true">
    ...
```
permission.INTERNET으로 서버와 통신하기위한 인터넷 권한을 얻고

만약 http로 시작하는 사이트에 접근해야한다면 usesCleartextTraffic로 true로 바꿔줍니다.
(https를 지원하는 사이트와 통신한다면 안적어줘도 됩니다.)



## data class 생성 (JSON만 해당)

결과 값으로 받을 json 형식에 맞춰 Data class를 생성해줍니다.

```json
{
  "result": true
   "data": [
      {
        "name" : "name"
        "content" : "content"
      },
      ...
      }]
 }
```
위의 json 형식을 data class로 바꾸어 나타내 본다면

```java
public class DTO {
    public boolean result;
    
    @SerializedName("data")
    public List<Data> data;

        public class Data{
            @SerializedName("name")
            public String name;
            
            @SerializedName("content")
            public String content;
        }
    }
    
    //결과 성공 여부를 String으로 확인
        @Override
    public String toString() {
        return "result ="+ result;
    }
}
```
만약 변수명을 다르게 사용하고 싶다면
@SerializedName("")를 붙여 원래 변수명을 넣어주고 그밑에 원하는 변수명을 사용하면 됩니다.


## Interface 정의

환경설정과 결과물을 받을 구조세팅까지 끝났다면 이제 통신 요청을 할 interface를 정의할 차례입니다.

```java
public interface RetrofitRequest {

//GET방식
    @GET("contents?typeCode=notice&size=10")
    Call<List<DTO>> getDTO1(@Query("content") String content);

//POST방식
    @FormUrlEncoded
    @POST("find-dto")
    Call<DTO> getDTO2(@Field("id") String i);
    
    //json을 그대로 넘기고 싶다면
    @POST("find-dto-json")
    Call<DTO> getDTO3(@Body RequestBody request);
    
}
```

## 사용법

```java
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("https:retrofitexample.co.kr:8000/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        RetrofitRequest retrofitRequest = retrofit.create(RetrofitRequest.class);

       
```

```java
 Call<List<DTO>> call = retrofitRequest.getDTO1("content");
        call.enqueue(new Callback<List<DTO>>() {
            @Override
            public void onResponse(Call<List<DTO>> call, Response<List<DTO>> response) {
                if(response.isSuccessful()){
                    String results = String.valueOf(response.body());
                    Log.d("Retrofit",results);
                }
            }

            @Override
            public void onFailure(Call<List<DTO>> call, Throwable t) {

            }

    });
    
     Call<DTO> call2 = retrofitRequest.getDTO2("i");
        call.enqueue(new Callback<DTO>() {
            @Override
            public void onResponse(Call<<DTO> call, Response<<DTO> response) {
                if(response.isSuccessful()){
                    String result = String.valueOf(response.body());
                    Log.d("Retrofit",result);
                }
            }

            @Override
            public void onFailure(Call<<DTO> call, Throwable t) {

            }

    });
   
   
         String content = "request"
         RequestBody requestbody = new RequestBody()
                                  .create(MediaType.parse("application/json"), "{\"data\":\"{'content':'"+content+"'}\"}");
                            
         Call<DTO> call3 = retrofitRequest.getDTO3(requestbody);
          call.enqueue(new Callback<DTO>() {
            @Override
            public void onResponse(Call<<DTO> call, Response<<DTO> response) {
                if(response.isSuccessful()){
                    String results = String.valueOf(response.body());
                    Log.d("Retrofit",results);
                }
            }

            @Override
            public void onFailure(Call<<DTO> call, Throwable t) {

            }

    });
```
