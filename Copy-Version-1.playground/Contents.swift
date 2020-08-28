import Foundation

var testInput: String = "Test"

copy()


// MARK: - Copy
func copy() {
    var readChar: Character?
    
    repeat {
        readChar = readFromKeyboard()
        if let writeChar = readChar {
            writeToPrinter(writeChar)
        }
    } while readChar != nil
}
// MARK: - Read Keyboard
func readFromKeyboard() -> Character? {
    guard !testInput.isEmpty else { return nil }
    return testInput.removeFirst()
}
// MARK: - Write Printer
func writeToPrinter(_ character: Character) {
    print("\n---Ready for printer---")
    print(character)
    print("---------Done---------")
}
