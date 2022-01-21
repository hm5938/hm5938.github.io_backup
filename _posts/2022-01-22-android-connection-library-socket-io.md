

## 환경설정

gradle에 socket.io를 추가시켜준다

```gradle
dependencies {
implementation ('io.socket:socket.io-client:2.0.0') {
        exclude group: 'org.json', module: 'json'
    }
    }
```
manifests에 android.permission.INTERNET 추가시켜준다.

```xml
 <uses-permission android:name="android.permission.INTERNET"/>
 ```
 
 ## 사용법
 
 1. [Socket 생성](Socket-생성)
 2. [server와 연결](server와-연결)
 3. [server에 이벤트 발생](server에-이벤트-발생)
 4. [event listener 활성화/ 비활성화](event-listener-활성화/-비활성화)
 5. [server와 연결 끊기](server와-연결-끊기)
 
 ### Soket 생성
 ```java
  private Socket socket;{
        try {
            socket = IO.socket("url");
        }catch (URISyntaxException e) {}
    }
 ```
 
 ### server와 연결
 ```java
 socket.connect();
 ```
 
 ### socket event 처리 listeners 생성
 ```java
 private Emitter.Listener listener = new Emitter.Listener() {
        @Override
        public void call(final Object... args) {
           runOnUiThread(new Runnable() {
                @Override
                public void run() {                  
                }
            });
        }
    };
 ```
 ### server에 이벤트 발생
 ```java
 socket.emit("event", data);
 
 ```
 
 ### event listener 활성화/ 비활성화
 ```java
 socket.on("event", listener);
 socket.off("event",listener)
 ```
 
 server와 연결 끊기
 ```java
  socket.disconnect();
 ```
 
 
 
 
 
