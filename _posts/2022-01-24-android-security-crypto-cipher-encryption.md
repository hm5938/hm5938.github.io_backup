---
layout: post
title:  "[Security] AES/RSA 암호화"
subtitle: "security"
categories: android
tags: android security aes rea crypto cipher encryption
comments: false
---

## 개요
> `javax.crypto.Cipher`를 이용하여  AES RSA 암호화를 해보자

- 목차
	- [crypto-cipher-encryption](#crypto-cipher-encryption) 
	- [AES로 암호화/복호화](#AES-암호화복호화)
	- [RSA 로 암호화/복호화](#RSA-로-암호화복호화)

## crypto-cipher-encryption

javax.crypto.Cipher 사용하여 AES RSA 암호화 하기

 AES로 암호화/복호화
 키의 길이에 따라서 AES-128, AES-192, AES-256이 있지만
 java 에서는 AES키 길이에 제한을 두기때문에 현재 공식적으로 AES-128밖에 지원하지 않음
 % 사용하려면 JRE의 정책 라이브러리를 갈아 끼우는 방법이 있다.


암호화에 사용할 키와 문자열 설정
```java
        // 암호화에 사용할 키, 디폴트 128bit(16Byte)로 설정해야함
        String encryptionKey = "AESencryptionkey";

        // 암호화할 문자열
        String target = "AES 암호화를 해보아요";
        
        //Cipher 객체 생성
        Cipher cipher = null;

```
## AES 암호화/복호화
AES 암호화

```java

            // AES Cipher 객체 생성
            cipher = Cipher.getInstance("AES");
            // 암호화 Chipher 초기화
            SecretKeySpec secretKeySpec = new SecretKeySpec(encryptionKey.getBytes(),"AES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);

            // 암호화 완료
            byte[] encryptBytes = cipher.doFinal(target.getBytes("UTF-8"));
```

 AES 복호화
```java    
            // 복호화 Chipher 초기화
            cipher.init(cipher.DECRYPT_MODE, secretKeySpec);
            
            // 똑같은 암호화키로 복호화
            byte[] decryptBytes = cipher.doFinal(encryptBytes);

```


## RSA 로 암호화/복호화
 
 암호화에 사용할 문자열 설정
```java

// 암호화할 문자열
        String target = "RSA 암호화를 해보아요";
//Cipher 초기화
        cipher = null;
//키를 생성할 객체생성
        KeyPairGenerator keypairgen = null;
        
```

 RSA 암호화 
```java
            // RSA 비밀키와 공개키를 생성
            keypairgen = KeyPairGenerator.getInstance("RSA");
            KeyPair keyPair = keypairgen.generateKeyPair();
            RSAPrivateKey privateKey = (RSAPrivateKey) keyPair.getPrivate();
            RSAPublicKey publicKey = (RSAPublicKey) keyPair.getPublic();

            // Cipher 객체 생성과 비밀키 초기화
            cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.ENCRYPT_MODE, privateKey);

            // 암호화 완료
            byte[] encryptBytes = cipher.doFinal(target.getBytes());
```

 RSA 복호화
```java
            // 복호화 Chipher 초기화, 비밀키와 쌍인 공개키로 복호화함.
            cipher.init(cipher.DECRYPT_MODE, publicKey);
            byte[] decryptBytes = cipher.doFinal(encryptBytes);
```
