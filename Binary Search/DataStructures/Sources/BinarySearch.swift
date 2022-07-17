

func findIndices(of value: Int, in array: [Int]) -> CountableRange<Int>? {
    guard let startIndex = startIndex(of: value, in: array, range: 0..<array.count)
  else {
    return nil
  }
    guard let endIndex = endIndex(of: value, in: array, range: 0..<array.count)
  else {
    return nil
  }
    return startIndex..<endIndex
}
