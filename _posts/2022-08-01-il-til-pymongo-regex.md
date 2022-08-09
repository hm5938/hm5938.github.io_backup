---
layout: post
title: "[Python] pymongo 검색기능 만들기"
subtitle: "til"
categories: il
tags: il til algorithm python regex pymongo
comments: false
---


파이썬으로 pymongo 다룰 때의  rgx 사용 flask 서버에서 pymongo를 사용해 검색기능을 만들면서 rgx 를 사용해 쿼리를 작성하려 했지만 rgx가 적용되지 않음.
    
    찾아보니 파이썬안에는 rgx를 따로 적용하는 기능이 없어 모듈을 임포트 한 후 사용해야한다는 것을 알게됨.
    
    import re 를 한 후 
    
    ```python

    rgx = re.compile('.*'+name_receive+'.*', re.IGNORECASE)
    
    ```
    위 코드로 regex 를 컴파일 시킨 후 적용하니 제대로 적용되어 해결!
