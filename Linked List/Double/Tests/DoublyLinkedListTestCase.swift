import XCTest
@testable import DataStructures

final class DoublyLinkedListTestCase: XCTestCase {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    let list = DoublyLinkedList<Int>()
    
    func test_linkingNodes() {
        node1.next = node2
        node2.previous = node1
        node2.next = node3
        node3.previous = node2
        
        XCTAssertEqual(String(describing: node1), "1 -> 2 -> 3  ")
    }
    
    func test_isEmpty() {
        XCTAssertTrue(list.isEmpty)
        
        list.append(1)
        list.append(2)
        list.append(3)
        
        XCTAssertFalse(list.isEmpty)
    }
    
    func test_append() {
        list.append(1)
        list.append(2)
        list.append(3)
        
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3 -> end")
    }
    
    func test_remove() {
        list.append(1)
        list.append(2)
        list.append(3)
        
        if let firstNode = list.first {
            XCTAssertEqual(list.remove(firstNode), 1)
        }
    }
}
