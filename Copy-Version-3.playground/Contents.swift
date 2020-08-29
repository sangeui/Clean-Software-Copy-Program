import Foundation

var testInput: String = "Test"

// 종이테이프 판독기로부터 입력을 받으려면 `true`
// 그렇지 않으면 `false`
var paperTapeReaderFlag = false

// 종이테이프 천공기로 출력을 하려면 `true`
// 그렇지 않으면 `false`
var punchedTapeWriterFlag = false

copy()

// MARK: - Copy
func copy() {
    var readChar: Character?
    
    repeat {
        // ternary 연산자를 이용해 입력 장치를 구분한다.
        readChar = paperTapeReaderFlag ? readFromPaperTapeReader() : readFromKeyboard()
        readChar = readFromKeyboard()
        if let writeChar = readChar {
            // ternary 연산자를 이용해 출력 장치를 구분한다.
            punchedTapeWriterFlag ? writeToPunchedTapeWriter(writeChar) : writeToPrinter(writeChar)
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
// MARK: - Write to Punched tape Writer
func writeToPunchedTapeWriter(_ character: Character) {
    print("\n---Ready for printer---")
    print(character)
    print("---------Done---------")
}
