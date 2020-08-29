import Foundation

var testInput: String = "Test"

// 종이 판독기로부터 입력을 받으려면 `true`
// 그렇지 않으면 `false`
var paperTapeReaderFlag = false

copy()

// MARK: - Copy
func copy() {
    var readChar: Character?
    
    repeat {
        // `ternary 연산자를 이용해 입력 장치를 구분한다.`
        readChar = paperTapeReaderFlag ? readFromPaperTapeReader() : readFromKeyboard()
        readChar = readFromKeyboard()
        if let writeChar = readChar {
            writeToPrinter(writeChar)
        }
    } while readChar != nil
}
// MARK: - Read from Keyboard
func readFromKeyboard() -> Character? {
    guard !testInput.isEmpty else { return nil }
    return testInput.removeFirst()
}
// MARK: - Read from Paper tape reader
func readFromPaperTapeReader() -> Character? {
    guard !testInput.isEmpty else { return nil }
    return testInput.removeFirst()
}
// MARK: - Write to Printer
func writeToPrinter(_ character: Character) {
    print("\n---Ready for printer---")
    print(character)
    print("---------Done---------")
}
