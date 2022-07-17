
import XCTest
@testable import DataStructures

final class BinarySearchTestCase: XCTestCase {
  func test_findIndices() {
    let array = [1, 2, 3, 3, 3, 4, 5, 5]
    XCTAssertEqual(findIndices(of: 1, in: array), 0..<1)
  }
  
  func test_binarySearch() {
    let array = [1, 5, 18, 32, 33, 33, 47, 49, 502]
    XCTAssertEqual(array.binarySearch(for: 5), 1)
  }
}
