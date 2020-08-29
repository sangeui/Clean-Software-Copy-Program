import Foundation

var testInput: String = "Test"

// Reader Protorol
protocol Reader {
    func read() -> Character?
}
class KeyboardReader: Reader {
    func read() -> Character? {
        guard !testInput.isEmpty else { return nil }
        return testInput.removeFirst()
    }
}
// Writer Protorol
protocol Writer {
    func write(_ character: Character)
}

class PrinterWriter: Writer {
    func write(_ character: Character) {
        print("\n---Ready for printer---")
        print(character)
        print("---------Done---------")
    }
}

func copy(reader: Reader = KeyboardReader(), writer: Writer = PrinterWriter()) {
    var readChar: Character?
    
        repeat {
            readChar = reader.read()
        if let writeChar = readChar {
            writer.write(writeChar)
        }
    } while readChar != nil
}
