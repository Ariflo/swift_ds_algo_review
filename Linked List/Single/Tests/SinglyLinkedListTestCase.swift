import XCTest
@testable import DataStructures

final class SinglyLinkedListTestCase: XCTestCase {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    var list = SinglyLinkedList<Int>()
    
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
        var list = SinglyLinkedList<Int>()
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
        var list1 = SinglyLinkedList<Int>()
        list1.append(1)
        list1.append(2)
        
        var list2 = list1
        list2.append(3)

        XCTAssertEqual(String(describing: list1), "1 -> 2 ")
        XCTAssertEqual(String(describing: list2), "1 -> 2 -> 3  ")
        
        if let node = list2.node(at: 0) {
             list2.remove(after: node)
        }
        
        XCTAssertEqual(String(describing: list2), "1 -> 3 ")
    }
    
    func test_reverse() {
        var list = SinglyLinkedList<Int>()
        
        list.append(1)
        list.append(2)
        list.append(3)
        
        XCTAssertEqual(String(describing: list.reversed()), "3 2 1 ")
    }
    
    func test_get_middle_node() {
        var list = SinglyLinkedList<Int>()
        
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        
        XCTAssertEqual(list.getMiddleNode()?.value, 3)
        
        var list2 = SinglyLinkedList<Int>()
        
        list2.append(1)
        list2.append(2)
        list2.append(3)
        
        XCTAssertEqual(list2.getMiddleNode()?.value, 2)
    }
    
    func test_reverse_list() {
        var list = SinglyLinkedList<Int>()
        
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3 -> 4   ")
        list.reverseList()
        XCTAssertEqual(String(describing: list), "4 -> 3 -> 2 -> 1   ")
    }
    
    func test_merge_two_lists() {
        var list1 = SinglyLinkedList<Int>()
        
        list1.append(-1)
        list1.append(4)
        list1.append(10)
        list1.append(11)
        
        var list2 = SinglyLinkedList<Int>()
        
        list2.append(1)
        list2.append(2)
        list2.append(3)
        list2.append(6)
        
        XCTAssertEqual(String(describing: list1.merge(with: list2)), "Optional(-1 -> 1 -> 2 -> 3 -> 4 -> 6 -> 10 -> 11       )")
    }
    
    func test_remove_all_occurences() {
        var list = SinglyLinkedList<Int>()
        
        list.append(-1)
        list.append(4)
        list.append(4)
        list.append(4)
        list.append(10)
        list.append(11)
        
        list.remove(all: 4)
        
        XCTAssertEqual(String(describing: list), "-1 -> 10 -> 11  ")
        
        var list2 = SinglyLinkedList<Int>()
        
        list2.append(1)
        list2.append(3)
        list2.append(3)
        list2.append(3)
        list2.append(3)
        list2.append(11)
        
        list2.remove(all: 3)
        
        XCTAssertEqual(String(describing: list2), "1 -> 11 ")
        
        var list3 = SinglyLinkedList<Int>()
        
        list3.append(1)
        list3.append(2)
        list3.append(3)
        list3.append(3)
        list3.append(3)
        list3.append(11)
        
        list3.remove(all: 2)
        
        XCTAssertEqual(String(describing: list3), "1 -> 3 -> 3 -> 3 -> 11    ")
        
        var list4 = SinglyLinkedList<Int>()
        
        list4.append(1)
        list4.append(2)
        list4.append(3)
        list4.append(3)
        list4.append(3)
        list4.append(11)
        
        list4.remove(all: 11)
        
        XCTAssertEqual(String(describing: list4), "1 -> 2 -> 3 -> 3 -> 3    ")
        
        var list5 = SinglyLinkedList<Int>()
        
        list5.append(1)
        list5.append(2)
        list5.append(3)
        list5.append(3)
        list5.append(3)
        list5.append(11)
        
        list5.remove(all: 1)
        
        XCTAssertEqual(String(describing: list5), "2 -> 3 -> 3 -> 3 -> 11    ")
    }
}
