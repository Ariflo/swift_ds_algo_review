import XCTest
@testable import DataStructures

final class SinglyLinkedListTestCase: XCTestCase {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    let list = SinglyLinkedList<Int>()
    
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
    
    func test_usingCollection() {
        let list = SinglyLinkedList<Int>()
        for i in 0...9 {
            list.append(i)
        }
        
        XCTAssertEqual(String(describing: list), "0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> 9         ")
        XCTAssertEqual(String(describing: list[list.startIndex]), "0")
        XCTAssertEqual(String(describing: Array(list.prefix(3))), "[0, 1, 2]")
        XCTAssertEqual(String(describing: Array(list.suffix(3))), "[7, 8, 9]")
        let sum = list.reduce(0, +)
        XCTAssertEqual(String(describing: sum), "45")
    }
    
    func test_cow() {
        let list1 = SinglyLinkedList<Int>()
        list1.append(1)
        list1.append(2)
        
        let list2 = list1
        list2.append(3)
//        TODO: Figure out why reference pointers are not working here
//        XCTAssertEqual(String(describing: list1), "1 -> 2 ")
        XCTAssertEqual(String(describing: list2), "1 -> 2 -> 3  ")
        
        if let node = list2.node(at: 0) {
          list2.remove(after: node)
        }
        
        XCTAssertEqual(String(describing: list2), "1 -> 3 ")
    }
}
