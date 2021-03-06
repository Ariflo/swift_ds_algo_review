import XCTest
@testable import DataStructures


final class BinaryTreeTestCase: XCTestCase {
    var tree: BinaryNode<Int> = {
        let zero = BinaryNode(value: 0)
        let one = BinaryNode(value: 1)
        let five = BinaryNode(value: 5)
        let seven = BinaryNode(value: 7)
        let eight = BinaryNode(value: 8)
        let nine = BinaryNode(value: 9)
        
        seven.leftChild = one
        one.leftChild = zero
        one.rightChild = five
        seven.rightChild = nine
        nine.leftChild = eight
        
        return seven
    }()
    
    func serialize<Element>(_ tree: BinaryNode<Element>) -> [Element?] {
        var array = [Element?]()
        
        tree.traversePreOrder{ array.append($0) }
        
        return array
    }
    
    func deserialize<Element>(_ array: inout [Element?]) -> BinaryNode<Element>? {
        guard let value = array.removeLast() else {
            return nil
        }
        
        let node = BinaryNode(value: value)
        
        node.leftChild = deserialize(&array)
        node.rightChild = deserialize(&array)
        
        return node
    }
    
    func deserialize<Element>(_ array: [Element?]) -> BinaryNode<Element>? {
        var reversed = Array(array.reversed())
        return deserialize(&reversed)
    }
    
    func test_serialize() {
        let expectedArray = [7, 1, 0, nil, nil, 5, nil, nil, 9, 8, nil, nil, nil]
        let serializedTree = serialize(tree)
        XCTAssertEqual(serializedTree, expectedArray)
        let deserializedArray = deserialize(expectedArray)
        XCTAssertEqual(deserializedArray?.description, tree.description)
    }
    
    ////////////////////////////////////////
    
    func test_visualizeBinaryTree() {
        print(tree.description)
    }
    
    func test_traverseInOrder() {
        var testArray: [Int] = []
        tree.traverseInOrder { testArray.append($0) }
        XCTAssertEqual(testArray, [0, 1, 5, 7, 8, 9])
    }
    
    func test_traversePreOrder() {
        var testArray: [Int?] = []
        tree.traversePreOrder {
            guard let value = $0 else { return }
            testArray.append(value)
        }
        XCTAssertEqual(testArray, [7, 1, 0, 5, 9, 8])
    }
    
    func test_traversePostOrder() {
        var testArray: [Int] = []
        tree.traversePostOrder { testArray.append($0) }
        XCTAssertEqual(testArray, [0, 5, 1, 8, 9, 7])
    }
}
