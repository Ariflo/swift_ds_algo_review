

import XCTest
@testable import DataStructures

final class HeapTestCase: XCTestCase {
  func test_init() {
    let heap = Heap(unsortedInts, areSorted: <)
    XCTAssertEqual( unsortedInts.sorted(by: >), Array(heap) )
  }

  func test_peek() {
    let heap = Heap(unsortedInts, areSorted: >)
    XCTAssertEqual(heap.peek(), 12)
  }

  func test_removeRoot() {
    var heap = Heap(unsortedInts, areSorted: >)
    XCTAssertEqual(heap.removeRoot(), 12)
  }

  func test_remove() {
    var heap = Heap(unsortedInts, areSorted: >)
    let index = heap.getFirstIndex(of: 3)!
    XCTAssertEqual(heap.remove(at: index), 3)
    XCTAssertEqual(Array(heap), [1, 1, 4, 6, 7, 8, 12])
  }

  func test_insert() {
    var heap = Heap(unsortedInts, areSorted: >)
    heap.insert(5)
    XCTAssertEqual(Array(heap), [1, 1, 3, 4, 5, 6, 7, 8, 12])
  }

  func test_isHeap() {
    let maxHeapArray = [
           5,
        4,    2,
      4, 3,  1
    ]
    XCTAssertTrue(maxHeapArray.isHeap(sortedBy: >))

    let minHeapArray = [
           1,
        2,     10,
      3, 3,  11, 11
    ]
    XCTAssertTrue(minHeapArray.isHeap(sortedBy: <))

    let invalidHeapArray = [
        0,
      1,  -1
    ]
    XCTAssertFalse(invalidHeapArray.isHeap(sortedBy: <))
    XCTAssertFalse(invalidHeapArray.isHeap(sortedBy: >))
  }

  private let unsortedInts = [1, 12, 3, 4, 1, 6, 8, 7]
}
