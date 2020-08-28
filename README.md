##### 클린 소프트웨어 (로버트 C. 마틴, 제이펍) 의 Copy 프로그램을 Swift 로 구현했다. 

---

```
요구사항

키보드에서 프린터로 문자를 복사하는 프로그램을 작성하라.
```

![the image for Copy diagram](https://github.com/sangeui/Clean-Software-Copy-Program/blob/master/Resources/Images/Copy.png)

위 다이어그램에서 볼 수 있듯이, 전체 애플리케이션은 3 개의 모듈 또는 서브프로그램을 가진다. 

가장 위에 있는 Copy 모듈은 아래의 다른 두 모듈을 호출한다. 

Copy 프로그램은 Keyboard 로부터 문자를 읽어들여 Printer 모듈로 보내 적당한 동작을 한다. 

아래는 위 다이어그램을 그대로 아래로 옮긴 코드이다. 

`readFromKeyboard` 는 `keyboard` 로부터 문자를 읽고, `writeToPrinter`  는 이 문자를 `printer` 로 전달한다. 

이 두 서브모듈은 `Copy` 에서 호출되어 실행된다. 

```swift
func copy() {
	while readFromKeyboard() { 
		writeToPrinter()
	}
}
func readFromKeyboard() {
	// Read from keyboard
}
func writeToPrinter() {
	// Write to Printer
}
```

이 정도면 요구사항을 충족시킨 것으로 보인다. 

---

하지만 요구사항은 변하기 마련인데, Copy 도 이를 피할 수는 없었다. 

```
변경된 요구사항

키보드에서 프린터로 문자를 복사하는 프로그램을 작성하라.
+ `종이 판독기`를 통해서도 문자를 읽어들여라.
```

위에서 작성한 구조와 코드는 `읽기` 의 동작이 `keyboard` 에 묶여있다고 볼 수 있다. 그러므로 이러한 동작을 `종이 판독기` 에 알맞게 변경하려면 추가적인 작업이 필요하다. 


