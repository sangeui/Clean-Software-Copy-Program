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

이 정도면 요구사항을 충족시킨 것으로 보인다. _version-1

---

하지만 요구사항은 변하기 마련인데, Copy 도 이를 피할 수는 없었다. 

```
변경된 요구사항-1

키보드에서 프린터로 문자를 복사하는 프로그램을 작성하라.
+ `종이테이프 판독기`를 통해서도 문자를 읽어들여라.
```

위에서 작성한 구조와 코드는 `읽기` 의 동작이 `keyboard` 에 묶여있다고 볼 수 있다. 그러므로 이러한 동작을 `종이테이프 판독기` 에 알맞게 변경하려면 추가적인 작업이 필요하다. 

책에 언급된 시나리오 따르면, 인터페이스 변경에 따른 비용 문제로 결국 `입력 장치 구분`을 위한 `전역 변수`를 사용하는 것으로 요구사항을 구현한다. 

```swift
// 종이테이프 판독기로부터 입력을 받으려면 `true`
// 그렇지 않으면 `false`
var paperTapeReaderFlag = false

// `ternary 연산자`를 이용해서 입력 장치를 구분
var char = paperTapeReaderFlag ? 
			readFromPTreader() : readFromKeyboard()
```

고작 입력장치를 `키보드`와 `종이테이프 판독기` 사이에서 결정하는 문제이기 때문에, 전역 변수를 사용하여 쉽게 해결할 수 있었다. _version-2

---

고객들은 소프트웨어가 동작하는 것을 확인하고 나서, 더 많은 요구사항을 원한다.

```
변경된 요구사항-2

키보드에서 프린터로 문자를 복사하는 프로그램을 작성하라.
`종이테이프 판독기`를 통해서도 문자를 읽어들여라.
+ `종이테이프 천공기`에도 출력할 수 있게 하라.
```

version-2 에서 해결한 방법으로 새로운 요구사항을 대처할 수 있을 것으로 보인다. 

`종이테이프 천공기` 출력 여부를 판단하기 위한 `전역 변수` 를 선언하고, 이를 사용해 기존의 `프린터` 로 출력할 것인지,  `종이테이프 천공기` 로 출력할 것인지 결정할 수 있다. 

```swift
// 종이테이프 천공기로 출력하려면 `true`
// 그렇지 않으면 `false`
var punchedTapeWriterFlag = false

// Copy
while ... {
	punchedTapeWriterFlag ? 
	writeToPTwriter(char) : writeToPrinter(char)
}
```

어렵지 않게 전역 변수와 ternary 연산자를 이용해 수정된 요구사항을 모두 반영했다. _version-3

---

다행히 입·출력장치가 각각 두 종류이기 때문에 위와 같은 방법으로 해결할 수 있었다. 하지만 요구사항 변경이 더 발생하여, 종류의 가짓수가 늘어나게 된다면 더이상 위 방법으로는 해결할 수 없게 된다.

최초 단순했던 Copy 프로그램의 구조는 요구사항이 변경됨에 따라 복잡해지고, 코드를 수정하는 것이 어려워진다. 

이를 애자일 방식으로 다시 구현해본다. 

---

개방 폐쇄 원칙을 가지고 최초 버전을 재구현 했을 때 핵심은 아래와 같다. 

```swift
protocol Reader {
	func read() -> Character?
}
class PrinterReader: Reader {
	func read() -> Character? {
	...
	}
}
func copy(reader: Reader = PrinterReader() {
	while reader.read() {
		...
	}
}
```

최초 버전에서는 Copy 모듈이 특정 장치에 종속되도록 구현되었다. 
(사실 이전 모든 버전에서 특정 장치에 종속적이다.)

`Copy` → `Specific Printer`

따라서 요구사항이 변경될 때마다 우리는 장치를 추가할 뿐이었지만 Copy 모듈까지 변경했어야 했다. 

이것을 이번에는 Copy 모듈과 장치 사이에 인터페이스를 집어 넣어, 그 종속성을 무너뜨렸다. 

`Copy` → `Interface` → `Specific Printer`

이렇게 중간에 인터페이스를 삽입함으로써, 장치의 추가가 있을 때마다 해당 인터페이스를 구현하도록 하면 되는 것이다. 

단순해 보이지만 이것은 Copy 프로그램이 엉망진창 되는 것을 막아주고, 앞으로 있을 요구사항 변경에 좀 더 유연하게 반응할 수 있도록 해준다. 
