6.1. RxAndroid 소개


-

RxAndroid 는 RxJava 에 최소한의 클래스를 추가하여 안드로이드 앱에서 리액티브 구성 요소를 쉽고 간편하게 사용하게 만드는 라이브러리이다.





-

RxAndroid 의 장점은…



간단한 코드로 복잡한 concurrency 프로그래밍을 할 수 있다.

비동기 구조에서 에러를 다루기 쉽다.

함수형 프로그래밍 기법도 부분적으로 적용할 수 있다.







6.1.1. 리액티브 라이브러리와 API


-
```
RxLifecycle

    RxJava 를 사용하는 안드로이드 앱용 라이프 사이클 처리 API. Trello 에서 만들어졌다.

```
```
RxBinding

    UI 위젯용 RxJava 바인딩 API
```

```
SqlBrite

    SQLiteOpenHelper 와 ContentResolver 클래스의 래퍼 클래스로 쿼리에 리액티브 스트림을 도입한다.

```
```
Android-ReactiveLocation

    위치 API 라이브러리(1.x 기준)

```
```
RxLocation

    위치 API 라이브러리(2.x 기준)

```
```
rx-preferences

    SharedPreferences 인터페이스

```
```
RxFit

    Fit 라이브러리

```
```
RxWear

    웨어러블 API 라이브러리
```

```
RxPermissions

    런타임 권한 라이브러리
```

```
RxNotification

    notification 을 관리하는 API
```

```
RxClipboard

    클립 보드용 RxJava 바인딩 API
```
```

RxBroadcast

    Broadcast 및 LocalBroadcast 에 관한 Rxjava 바인딩 API
```

```
RxAndroidBie

    블루투스 LE 장치를 다루기 위한 라이브러리

```
```
RxImagePicker

    갤러리 또는 카메라에서 이미지를 선택하기 위한 리액티브 라이브러리
```


```ReactiveNetwork

    네트워크 연결 상태나 인터넷 연결 상태를 확인하는 라이브러리
```
```

ReactiveBeacons

    블루투스 LE 기반 비컨을 수신하는 리액티브 라이브러리

```
```
RxDataBinding

    데이터 바인딩 라이브러리용 RxJava2 바인딩 API


```


 




6.1.2. 안드로이드 스튜디오 환경 설정

```java
-

아래와 같은 녀석들을 dependency 로 추가해준다.

‘io.reactivex.rxjava2:rxandroid:2.0.1’ // 최신버전 사용하세용

‘com.trello.rxlifecycle2:rxlifecycle-android:2.1.0’ // 최신버전 사용하세용
```








6.2. RxAndroid 기본


-

RxAndroid 에서 제공하는 스케줄러는..

```java
AndroidSchedulers.mainThread()

HandlerScheduler.from(handler)
```






6.2.1. Hello world 예제






6.2.2. 제어 흐름






6.2.3. RxLifecycle 라이브러리


-
```
RxActivity

    Activity 에 대응
```


```RxDialogFragment

    DialogFragment (native/support) 에 대응
```

```
RxFragment

    Fragment(native/ support) 에 대응

```
```
RxPreferenceFragment

    PreferenceFragment 에 대응

```
```
RxAppCompatActivity

    Support AppCompatActivity 대응

```
```
RxAppCompatDialogFragment

    Support AppCompatDialogFragment 대응

```
```
RxFragmentActivity

    Support FragmentActivity 대응

```



-

사용하려면 아래 녀석들의 dependency 를 추가해야 한다.

// 버전은 최신을 사용하세요!
‘com.trello.rxlifecycle2:rxlifecycle:2.0.1’

‘com.trello.rxlifecycle2:rxlifecycle-android:2.0.1’

‘com.trello.rxlifecycle2:rxlifecycle-components:2.0.1’





-
```java
public class HelloActivity extends RxAppCompatActivity{
    @BindView(R.id.textview)
    TextView textView;
 
    private Unbinder mUnbinder;
 
    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
 
        mUnbinder = ButterKnife.bind(this);
 
        Observable.just(“Hello, rx world!”)
            .compose(bindToLifecycle()) // lifecycle 에 따라 자동 해제되도록 함
            .subscribe(textView::setText);
    }
 
    @Override
    protected void onDestroy(){
        super.onDestroy();
        if(mUnbinder != null){
            mUnbinder.unbind();
        }
    }
}

```
-
돼왕 : compose 함수는 전달받은 observable 을 새로운 observable 로 변환하는 역할을 한다.
```java
public final <R> Observable<R> compose(ObservableTransformer<? super T, ? extends R> composer) {
     return wrap(((ObservableTransformer<T, R>) ObjectHelper.requireNonNull(composer, "composer is null")).apply(this));
}

ex)
?
1
2
3
Observable.range(1, 5)
        .compose { observable -> observable.map { "${it}0" } }
        .forEach { println(it) }
```
그냥 map 하면 되지 이 녀석을 왜 쓰는가? 
lambda 를 대입하여 반복되는 패턴이나 특정 로직을 함수화하여 적용할 수 있다.
대표적인 예는 subscribeOn(IO).observeOn(Main) 과 같은 로직을 Observable 에 대한 kotlin extension 으로 정의해서 쓰기 좋달까?



6.2.4. UI 이벤트 처리


-

이벤트 리스너 인터페이스에 포함된 콜백 메서드들..



onClick()

onLongClick()

onFocusChange()

onKey()

onTouch()

onCreateContextMenu()





-
```java

Observable.create( s -> mButton.setOnClickListener(s::onNext) )
    .map(s -> “clicked lambda”)
    .subscribe(this::log);
->

RxView.clicks(mButton)
    .map(s -> “clicked rxbinding”)
    .subscribe(this::log);

```
-

debounce 는 설정한 timeSpan 기준으로 마지막 값만 emit 한다.

debounce 를 이용하면 중복 실행을 예방하는 데 좋다.





```java
RxTextView.textChangeEvents(mSearchBox)
    .debounce(400, TimeUnit.MILLISECONDS)
    .filter(s -> !TextUtils.isEmpty(s.text().toString()))
    .observeOn(AndroidSchedulers.mainThread())
    .subscribeWith(view -> log(“Search “ + view.text().toString()); );


```
 



6.3. RxAndroid 활용


6.3.1. 리액티브 RecyclerView


-

RecyclerView 클래스와 함께 사용하는 주요 클래스



Adapter : 데이터 셋의 아이템을 나타내는 뷰를 생성

ViewHolder : 재활용 뷰에 대한 모든 서브 뷰 저장

LayoutManager : 뷰에 있는 아이템을 배치하고 관리

ItemDecoration : 아이템을 꾸미는 서브 뷰 제어

ItemAnimation : 아이템을 추가, 정렬, 제거할 때 애니메이션 효과







6.3.2. 안드로이드 스레드를 대체하는 RxAndroid






6.3.3. REST API 를 활용한 네트워크 프로그래밍


-

defer() 는 대표적인 비동기 함수로 supplier( () -> T )를 매개변수로 사용하고 T의 데이터 타입은 Callable<? extends ObservableSource<? extends T>> 이다.



이는 구독이 발생할 때 Observable 을 생성한다.









6.4. 메모리 누수


6.4.1. 해결책 1: Disposable 인터페이스를 이용하여 명시적으로 자원 해제


-
```java
private Disposable mDisposable;
 
// somewhere
mDisposable = Observable.create( e -> {
    e.onNext(“Hello World”);
    e.onComplete();
})
    .subscribe( s-> textView.setText(s));
 
// onDestroy
if(mDisposible.isDisposed() == false){
    mDisposable.dispose();
}

```

6.4.2. 해결책 2: RxLifecycle 라이브러리 이용




Activity 를 RxAppCompatActivity 등을 상속하게 하고..
```java
Observable.create( e ->{
    e.onNext(“Hello World!”);
    e.onComplete();
})
.compose(bindUntilEvent(ActivityEvent.DESTROY))
// or .compose(bindToLifecycle())
.subscribe(mTextView::setText);


```

6.4.3. 해결책 3 : CompositeDisposable 클래스 이용


```java
private CompositeDisposable mCompositeDisposable = new CompositeDisposable();
 
// somewhere
Disposable disposable = Observable.create( e -> {
    e.onNext(“Hello World!”);
    e.onComplete();
})
.subscribe(textView::setText);
mCompositeDisposable.add(disposable);
 
// onDestroy
if(mCompositeDisposable.isDisposed() == false){
    mCompositeDisposable.dispose();
}

```
