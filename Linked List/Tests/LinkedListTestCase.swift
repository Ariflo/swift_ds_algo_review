/// Copyright (c) 2019 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import XCTest
@testable import DataStructures

final class LinkedListTestCase: XCTestCase {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    let list = LinkedList<Int>()
    
    func test_linkingNodes() {
        node1.next = node2
        node2.next = node3
        
        XCTAssertEqual(String(describing: node1), "1 -> 2 -> 3  ")
    }
    
    func test_push() {
        list.push(3)
        list.push(2)
        list.push(1)
        
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3  ")
    }
    
    func test_append() {
        list.append(1)
        list.append(2)
        list.append(3)
        
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3  ")
    }
    
    func test_insert() {
        list.push(3)
        list.push(2)
        list.push(1)
        
        var middleNode = list.node(at: 1)!
        
        for _ in 1...4 {
          middleNode = list.insert(-1, after: middleNode)
        }
        
        XCTAssertEqual(String(describing: list), "1 -> 2 -> -1 -> -1 -> -1 -> -1 -> 3      ")
    }
    
    func test_pop() {
        list.push(3)
        list.push(2)
        list.push(1)
        
        let poppedValue = list.pop()
        
        XCTAssertEqual(String(describing: poppedValue), "Optional(1)")
    }
    
    func test_removeLast() {
        list.push(3)
        list.push(2)
        list.push(1)
        
        let removedValue = list.removeLast()
        
        XCTAssertEqual(String(describing: removedValue), "Optional(3)")
    }
    
    func test_removeAfter() {
        list.push(3)
        list.push(2)
        list.push(1)
        
        let node = list.node(at: 0)!
        let removedValue = list.remove(after: node)
        
        XCTAssertEqual(String(describing: removedValue), "Optional(2)")
    }
}
