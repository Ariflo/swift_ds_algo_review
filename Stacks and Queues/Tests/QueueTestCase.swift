/// Copyright (c) 2019 Razeware LLC
/// 
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import XCTest
@testable import DataStructures

final class QueueTestCase: XCTestCase {
    
    var queueArray = QueueArray<String>()
    var queueLinkList = QueueLinkedList<String>()
    var queueRingBuffer = QueueRingBuffer<String>(count: 5)
    var queueStack = QueueStack<String>()
    
    override func setUp() {
        // MARK: QueueArray
        queueArray.enqueue("Pusheen")
        queueArray.enqueue("Keyboard Cat")
        queueArray.enqueue("Lil Bub")
        
        // MARK: QueueLinkedList
        queueLinkList.enqueue("Milo")
        queueLinkList.enqueue("Sassy")
        queueLinkList.enqueue("Ozma")
        
        // MARK: QueueRingBuffer
        queueRingBuffer.enqueue("Tom")
        queueRingBuffer.enqueue("Betty")
        queueRingBuffer.enqueue("Klein")
        
        // MARK: QueueStack
        queueStack.enqueue("Brady")
        queueStack.enqueue("Sammy")
        queueStack.enqueue("Tod")
    }
    
    override func tearDown() {
        clearAllQueues()
    }
    
   func clearAllQueues() {
        while !queueArray.isEmpty &&
                !queueLinkList.isEmpty &&
                !queueRingBuffer.isEmpty &&
                !queueStack.isEmpty {
            queueArray.dequeue()
            queueLinkList.dequeue()
            queueRingBuffer.dequeue()
            queueStack.dequeue()
        }
    }
    
    func setupSwiftExcercise() {
        queueArray.enqueue("S")
        queueArray.enqueue("W")
        queueArray.enqueue("I")
        queueArray.enqueue("F")
        queueArray.enqueue("T")
        
        queueLinkList.enqueue("S")
        queueLinkList.enqueue("W")
        queueLinkList.enqueue("I")
        queueLinkList.enqueue("F")
        queueLinkList.enqueue("T")
        
        queueRingBuffer.enqueue("S")
        queueRingBuffer.enqueue("W")
        queueRingBuffer.enqueue("I")
        queueRingBuffer.enqueue("F")
        queueRingBuffer.enqueue("T")
        
        queueStack.enqueue("S")
        queueStack.enqueue("W")
        queueStack.enqueue("I")
        queueStack.enqueue("F")
        queueStack.enqueue("T")
    }
    
    // MARK: Enqueue
    func test_enqueueArray() {
        XCTAssertEqual(queueArray.peek, "Pusheen")
    }
    func test_enqueueLinkedList() {
        XCTAssertEqual(queueLinkList.peek, "Milo")
    }
    func test_enqueueRingBuffer() {
        XCTAssertEqual(queueRingBuffer.peek, "Tom")
    }
    func test_enqueueStack() {
        XCTAssertEqual(queueStack.peek, "Brady")
    }
    func test_enqueue_SWIFT(){
        clearAllQueues()
        setupSwiftExcercise()
        
        XCTAssertEqual(queueArray.peek, "S")
        XCTAssertEqual(queueLinkList.peek, "S")
        XCTAssertEqual(queueRingBuffer.peek, "S")
        XCTAssertEqual(queueStack.peek, "S")
    }
    
    // MARK: Dequeue
    func test_dequeueArray() {
        queueArray.dequeue()
        queueArray.dequeue()
        XCTAssertEqual(queueArray.peek, "Lil Bub")
        queueArray.dequeue()
        XCTAssertTrue(queueArray.isEmpty)
    }
    func test_dequeueLinkedList() {
        queueLinkList.dequeue()
        queueLinkList.dequeue()
        XCTAssertEqual(queueLinkList.peek, "Ozma")
        queueLinkList.dequeue()
        XCTAssertTrue(queueLinkList.isEmpty)
    }
    func test_dequeueRingBuffer() {
        queueRingBuffer.dequeue()
        queueRingBuffer.dequeue()
        XCTAssertEqual(queueRingBuffer.peek, "Klein")
        queueRingBuffer.dequeue()
        XCTAssertTrue(queueRingBuffer.isEmpty)
    }
    func test_dequeueStack() {
        queueStack.dequeue()
        queueStack.dequeue()
        XCTAssertEqual(queueStack.peek, "Tod")
        queueStack.dequeue()
        XCTAssertTrue(queueStack.isEmpty)
    }
    func test_dequeue_SWIFT() {
        clearAllQueues()
        setupSwiftExcercise()
        
        queueArray.enqueue("R")
        queueArray.enqueue("O")
        queueArray.dequeue()
        XCTAssertEqual(queueArray.peek, "W")
        queueArray.enqueue("C")
        queueArray.dequeue()
        queueArray.dequeue()
        XCTAssertEqual(queueArray.peek, "F")
        queueArray.enqueue("K")
        queueArray.dequeue()
        queueArray.dequeue()
        queueArray.dequeue()
        queueArray.dequeue()
        queueArray.dequeue()
        queueArray.dequeue()
        XCTAssertTrue(queueArray.isEmpty)
        
        queueLinkList.enqueue("R")
        queueLinkList.enqueue("O")
        queueLinkList.dequeue()
        XCTAssertEqual(queueLinkList.peek, "W")
        queueLinkList.enqueue("C")
        queueLinkList.dequeue()
        queueLinkList.dequeue()
        XCTAssertEqual(queueLinkList.peek, "F")
        queueLinkList.enqueue("K")
        queueLinkList.dequeue()
        queueLinkList.dequeue()
        queueLinkList.dequeue()
        queueLinkList.dequeue()
        queueLinkList.dequeue()
        queueLinkList.dequeue()
        XCTAssertTrue(queueLinkList.isEmpty)
        
        XCTAssertFalse(queueRingBuffer.enqueue("R"))
        XCTAssertFalse(queueRingBuffer.enqueue("O"))
        XCTAssertEqual(queueRingBuffer.dequeue(), "S")
        XCTAssertTrue(queueRingBuffer.enqueue("C"))
        XCTAssertEqual(queueRingBuffer.dequeue(), "W")
        XCTAssertEqual(queueRingBuffer.peek, "I")
        XCTAssertEqual(queueRingBuffer.dequeue(), "I")
        XCTAssertTrue(queueRingBuffer.enqueue("K"))
        
        queueStack.enqueue("R")
        queueStack.enqueue("O")
        queueStack.dequeue()
        XCTAssertEqual(queueStack.peek, "W")
        queueStack.enqueue("C")
        queueStack.dequeue()
        queueStack.dequeue()
        XCTAssertEqual(queueStack.peek, "F")
        queueStack.enqueue("K")
        queueStack.dequeue()
        queueStack.dequeue()
        queueStack.dequeue()
        queueStack.dequeue()
        queueStack.dequeue()
        queueStack.dequeue()
        XCTAssertTrue(queueStack.isEmpty)
    }
    
    func test_monopoly_organizer() {
        var players = QueueArray<String>()
        
        players.enqueue("Arian")
        players.enqueue("Aisha")
        players.enqueue("Diana")
        players.enqueue("John")
        players.enqueue("Mike")
        
        XCTAssertEqual(players.nextPlayer(), "Arian")
        XCTAssertEqual(players.nextPlayer(), "Aisha")
        XCTAssertEqual(players.nextPlayer(), "Diana")
        XCTAssertEqual(players.nextPlayer(), "John")
        XCTAssertEqual(players.nextPlayer(), "Mike")
        // Test New Round
        XCTAssertEqual(players.nextPlayer(), "Arian")
        XCTAssertEqual(players.nextPlayer(), "Aisha")
        XCTAssertEqual(players.nextPlayer(), "Diana")
    }
    
    func test_reversed() {
        var reversedQueueArray = QueueArray<String>()
        
        reversedQueueArray.enqueue("Lil Bub")
        reversedQueueArray.enqueue("Keyboard Cat")
        reversedQueueArray.enqueue("Pusheen")

        XCTAssertEqual(queueArray.reversed(), reversedQueueArray)
    }
    
    func test_deque() {
        queueLinkList.enqueue("Max", to: .back)
        queueLinkList.enqueue("Naria", to: .front)
        
        XCTAssertEqual(queueLinkList.dequeue(from: .front), "Naria")
        XCTAssertEqual(queueLinkList.dequeue(from: .back), "Max")
        
        XCTAssertEqual(queueLinkList.peek(from: .back), "Ozma")
        XCTAssertEqual(queueLinkList.peek(from: .front), "Milo")
    }
    
}


import XCTest
@testable import DataStructures

final class QueueTestCase: XCTestCase {
  var queueArray = QueueArray<String>()
  var queueStack = QueueStack<String>()
    
  override func setUp() {
    queueArray.enqueue("Pusheen")
    queueArray.enqueue("Keyboard Cat")
    queueArray.enqueue("Lil Bub")

    queueStack.enqueue("Milo")
    queueStack.enqueue("Sassy")
    queueStack.enqueue("Ozma")
  }
  
  func test_enqueueArray() {
      XCTAssertEqual(queueArray.peek, "Pusheen")
  }
  
  func test_enqueueStack() {
      XCTAssertEqual(queueStack.peek, "Milo")
  }
  
  func test_dequeueArray() {
      queueArray.dequeue()
      queueArray.dequeue()
      XCTAssertEqual(queueArray.peek, "Lil Bub")
      queueArray.dequeue()
      XCTAssertTrue(queueArray.isEmpty)
  }
  
  func test_dequeueStack() {
      queueStack.dequeue()
      queueStack.dequeue()
      XCTAssertEqual(queueStack.peek, "Ozma")
      queueStack.dequeue()
      XCTAssertTrue(queueStack.isEmpty)
  }
}
