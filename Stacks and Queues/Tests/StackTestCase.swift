import XCTest
@testable import DataStructures

final class StackTestCase: XCTestCase {
    var stack = Stack<Int>()
  
  override func setUp() {
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
  }
  
  func test_push() {
    XCTAssertEqual(stack.debugDescription, "1 2 3 4")
  }
  
  func test_pop() {
    XCTAssertEqual(stack.pop(), 4)
  }
  
  func test_peek() {
    XCTAssertEqual(stack.peek(), 4)
  }
  
  func test_isEmpty() {
    XCTAssertFalse(stack.isEmpty)
  }
  
  func test_initWithArray() {
    let array = [1, 2, 3, 4]
    XCTAssertEqual(stack, Stack(array))
  }
  
  func test_arrayLiteral() {
    let stack: Stack = ["blueberry", "plain", "potato"]
    XCTAssertEqual(stack, ["blueberry", "plain", "potato"])
  }
  
  func test_reverse_the_stack() {
      func printInReverse<T:Equatable>(_ array: [T]) -> String {
          guard !array.isEmpty else {
              return ""
          }
          var stack = Stack<T>()
          var result = ""

          for value in array {
            stack.push(value)
          }

          while let value = stack.pop() {
              result.append(" \(value)")
          }
          
          return result
      }
      XCTAssertEqual(printInReverse([1,2,3,4]), " 4 3 2 1")
      
      let anotherArray = ["blueberry", "plain", "potato"]
      XCTAssertEqual(printInReverse(anotherArray), " potato plain blueberry")
  }
    
  func test_is_balanced_parens() {
      func isBalancedParens(_ input: String) -> Bool {
          var stack = Stack<Character>()

          for character in input {
            if character == "(" {
              stack.push(character)
            } else if character == ")" {
              if stack.isEmpty {
                return false
              } else {
                stack.pop()
              }
            }
          }
          
          return stack.isEmpty
        }
        
        XCTAssertTrue(isBalancedParens("h((e))llo(world)()"))
        XCTAssertFalse(isBalancedParens("(hello world"))
    }
}
