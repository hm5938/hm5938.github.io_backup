---
layout: post
title:  "[RxJava] Backpressure이란?"
subtitle: "rxjava"
categories: android
tags: android rxjava rxandroid backpressure flowable buffer 
comments: false
---


## 개요
> Backpressure(배압)에 대해 알아보고, Folowable을 사용해보자
  
- 목차
	- [Backpressure](#backpressure) 
	- [Flowable](#flowable)
	- [Observable to Flowable](#observable-to-flowable)
	- [둘중 어느것을 사용할까?](#둘중-어느것을-사용할까)
	
 
## Backpressure
---
Observable은 푸시를 기반으로 하는 성격을 가진다. (배출)

동기적 호출. 즉 하나의 쓰레드에서 배출할 경우에는 생성과 배출이 순서대로 잘 이루어진다.
하지만, 비동기적 호출시 생성과 배출이 제대로 일어나지 않을 수 있다. 

그럴때 backpressure(배압)이 필요하다

```java
public class MainActivity extends AppCompatActivity {

    static final class MyItem {
        final int id;

        MyItem(int id){
            this.id = id;
            System.out.println("Constructing MyItem " + id);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        text=findViewById(R.id.text);

        Observable.range( 1, 999_999_999)
                .map(MyItem::new)
                .subscribe(myItem -> {
                    sleep(50);
                    System.out.println("Received MyItem : " + myItem.id);
                });
    }
}

---
I/System.out: Constructing MyItem 1
I/System.out: Received MyItem : 1
    Constructing MyItem 2
I/System.out: Received MyItem : 2
    Constructing MyItem 3
I/System.out: Received MyItem : 3
    Constructing MyItem 4
I/System.out: Received MyItem : 4
    Constructing MyItem 5
```

```java

Observable.range( 1, 999_999_999)
                .map(MyItem::new)
                .observeOn(Schedulers.io())
                .subscribe(myItem -> {
                    sleep(50);
                    System.out.println("Received MyItem : " + myItem.id);
                });

---
 Constructing MyItem 78642
    Constructing MyItem 78643
    Constructing MyItem 78644
    Constructing MyItem 78645
I/System.out: Constructing MyItem 78646
    Constructing MyItem 78647
I/System.out: Received MyItem : 100
I/System.out: Constructing MyItem 78648
    Constructing MyItem 78649
    Constructing MyItem 78650
    Constructing MyItem 78651
```

배출보다 생성이 더 많은 것을 알수있다. 이 부분을 무시하면 OutOfMemoryError가 발생될 수 있다.

## Flowable

```java
        Flowable.range( 1, 999_99)
                .map(MyItem::new)
                .observeOn(Schedulers.io())
                .subscribe(myItem -> {
                    sleep(50);
                    System.out.println("Received MyItem : " + myItem.id);
                });
---
 Constructing MyItem 124
    Constructing MyItem 125
    Constructing MyItem 126
    Constructing MyItem 127
    Constructing MyItem 128
I/System.out: Received MyItem : 1
I/System.out: Received MyItem : 2

```

128개의 생성이 이루어지고 96개의 배출이 이루어지고 있다. 그리고 다시 96개의 생성이 이루어지고. 있다.

여기에서 재밌는 점은 왜 128개의 배출이 처음에 이루어지지 않았는가 이다.

만약 96개의 생성이 이루어지고 96개의 배출이 이루어진다고 가정하면 다음 96개의 작업에 대해서 준비를 하는 과정에서 시간이 딜레이가 될수 있다는 점이다.

이걸 유휴시간이라고 말하는데 그 시간동안 준비된 작업을 제공하여 처리량을 높일수 있다고 한다.

즉 공장에서 더 많은 것을 기다리는 동안 주문을 공급하기 위해 약간의 재고를 보유한 창고와 비슷하다고 보면 된다.

```java
Flowable.range(0, 1000000)
    .onBackpressureBuffer()
    .observeOn(Schedulers.computation())
    .subscribe(new FlowableSubscriber<Integer>() {
        @Override
        public void onSubscribe(Subscription s) {

        }
        @Override
        public void onNext(Integer integer) {
            Log.d(TAG, "onNext: " + integer);
        }
        @Override
        public void onError(Throwable t) {
            Log.e(TAG, "onError: ", t);
        }
        @Override
        public void onComplete() {

        }
    });
```
`Flowable`은 `Observer` 대신에 `FlowableSubscreiber`을 사용한다.



## Observable to Flowable
`toFlowable()`로 변환이 가능하다.
```java
flowable = observable.toFlowable(BackpressureStrategy.BUFFER)
```

__BackpressureStrategy.BUFFER__
무제한 버퍼를 제공합니다. (기본값인 128개가 아닙니다.)

따라서 생산하는 데이터 개수가 많고, 수신하여 처리하는쪽이 너무 느릴경우 OutOfMemory가 발생할 수 있습니다.


__BackpressureStrategy.DROP__
수신자가 처리중에 생산자로 부터 전달을 받으면 해당 데이터는 버립니다.

개념상 10개를 생성하더라도 1개를 수신중이라면 나머지 9개는 버려지는 개념이나, 여기도 기본 버퍼(128개)가 존재합니다.

따라서 기본 버퍼개수 128개까지는 버퍼에 쌓여있어 순차적으로 수신자가 처리하나, 버퍼에 담기지 못하는 129개째 부터 수신중에 생산된 데이터 이므로 버려집니다.

수신자의 동작 기준으로 데이터를 처리하고, 처리중에 생산된 데이터는 버려지며, 수신 처리가 끝나면 그 다음으로 수신하는 데이터를 처리합니다.


__BackpressureStrategy.ERROR__
소비쪽에서 생산을 따라잡을 수 없는경우 error를 발생시킵니다.

단 기본 버퍼인 128개는 제공합니다. 
기본 buffer 크기인 128개 까지는 데이터 방출이후에 처리가 따라가지 못하므로 onError()을 호출 하고 MissingBackpressureException을 발생시킵니다.


__BackpressureStrategy.LATEST__
Drop과 유사하게 수신 처리중에 받은 데이터는 무시됩니다. 다만 무시할때 마지막 배출된 값을 저장하여 최종값을 유지하고 있습니다.

수신쪽의 처리가 완료되면 무시된 값들중 최종값 하나를 전달한 후 이후에 배출되는 값을 수신 받습니다.


__BackpressureStrategy.MISSING__
Missing값은 기본적으로 Flowable에서 제공하는 backpressure를 사용하지 않겠다는 의미 입니다.

다만 위에서 언급한 strategy와 동일하게 동작시키기 위해 추가적인 operator를 제공합니다.

* onBackpressureBuffer()
BackpressureStrategy.MISSING을 사용하고, onBackpressureBuffer()사용하면 BackpressureStrategy.BUFFER를 사용한 것과 동일하게 동작 합니다.

다만 onBackpressureBuffer()는 인자값으로 버퍼 크기를 한정할 수 있습니다.
```java
... 
flowable.onBackpressureBuffer(20)
        .observeOn(Schedulers.computation()) 
        .subscribe(MySubscriber(waitingJob)) 
...

```

* onBackpressureDrop()

BackpressureStrategy.DROP과 동일하지만 drop되는 정보를 넘겨받을 수 있습니다.
```
... 
flowable.onBackpressureDrop{println("Drop item $it")} 
...
```
* onBackpressureLatest()
이 동작은 BackpressureStrategy.LATEST와 동일합니다.



## 둘중 어느것을 사용할까?

__Observable 사용 시기__
* 최대 1000개 이하의 요소의 데이터를 가지고 있을 때. 즉, 요소가 너무 적어서 `OOME`[outofmemory]의 가능성이 없을 시.
* 마우스 이동이나 터치 이벤트와 같은 GUI 이벤트를 다룰 수 있습니다. 이러한 이벤트는 거의 합리적으로 역압력을 가할 수 없으며 자주 발생하지 않습니다. 관측 가능으로 1000Hz 이하의 요소 주파수를 처리할 수 있지만 어쨌든 샘플링/반격을 사용하는 것을 고려해 보십시오.
* 흐름이 본질적으로 동기적이지만 플랫폼이 Java Stree를 지원하지 않거나 해당 플랫폼의 기능을 사용하지 않을 때.

__Flowable 사용 시기__
* 어딘가에서 어떤 방식으로 생성되는 10k+의 요소들을 다루는 것으로, 체인은 발생되는 양을 제한하도록 소스를 지시할 수 있다.
디스크에서 파일을 읽거나 구문 분석하는 것은 본질적으로 차단 및 꺼내기 기반이며, 예를 들어 지정된 요청량에 대해 이 파일에서 읽은 행의 개수와 같이 제어하면서 역압력과 함께 잘 작동합니다.
* JDBC를 통해 데이터베이스에서 읽는 것도 차단 및 풀 기반이며 사용자가 전화를 걸어 제어합니다. ResultSet.next() 각 다운스트림 요청에 대한 것입니다.
* 네트워크가 도움이 되거나 사용된 프로토콜이 논리적 양을 요청하는 것을 지원하는 네트워크(스트리밍) IO입니다.
많은 차단 및/또는 풀 기반 데이터 소스로, 나중에 차단되지 않는 대응형 API/드라이버를 얻을 수 있습니다.

