import XCTest
@testable import DataStructures

final class SortingTestCase: XCTestCase {
  var testArray = [7, 2, 6, 3, 3, 9, 15, 4, 11]
  let sortedArray = [2, 3, 3, 4, 6, 7, 9, 11, 15]
  
  func test() {
    XCTAssertEqual(mergeSort(testArray), sortedArray)
  }
}
