import XCTest
@testable import DataStructures

final class BufferTestCase: XCTestCase {
    var buffer = RingBuffer<Int>(count: 5)
    
    override func setUp() {
        buffer.write(123)
        buffer.write(456)
        buffer.write(789)
        buffer.write(666)
    }
    
    func test_write() {
        XCTAssertEqual(String(describing: buffer), "[123, 456, 789, 666]")
    }
    
    func test_read() {
        XCTAssertEqual(String(describing: buffer.read()!), "123")
        XCTAssertEqual(String(describing: buffer.read()!), "456")
        XCTAssertEqual(String(describing: buffer.read()!), "789")
    }
    
    func test_first() {
        XCTAssertEqual(String(describing: buffer.first!), "123")
    }
    
    func test_isFull() {
        XCTAssertFalse(buffer.isFull)
        buffer.write(777)
        XCTAssertTrue(buffer.isFull)
        buffer.read()
        XCTAssertFalse(buffer.isFull)
    }
}
