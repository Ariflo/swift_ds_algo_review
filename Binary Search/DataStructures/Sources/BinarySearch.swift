

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

func startIndex(of value: Int, in array: [Int], range: CountableRange<Int>) -> Int? {
    let middle = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    
    if middle == 0 || middle == array.count - 1 {
        if array[middle] == value {
            return middle
        } else {
            return nil
        }
    }
    
    if array[middle] == value {
        if array[middle - 1] != value {
            return middle
        } else {
            return startIndex(of: value, in: array, range: range.lowerBound..<middle)
        }
    } else if value < array[middle] {
        return startIndex(of: value, in: array, range: range.lowerBound..<middle)
    } else {
        return startIndex(of: value, in: array, range: middle..<range.upperBound)
    }
}

func endIndex(of value: Int, in array: [Int], range: CountableRange<Int>) -> Int? {
    let middle = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    
    if middle == 0 || middle == array.count - 1 {
        if array[middle] == value {
            return middle + 1
        } else {
            return nil
        }
    }
    
    if array[middle] == value {
        if array[middle + 1] != value {
            return middle + 1
        } else {
            return endIndex(of: value, in: array, range: middle..<range.upperBound)
        }
    } else if value < array[middle] {
        return endIndex(of: value, in: array, range: range.lowerBound..<middle)
    } else {
        return endIndex(of: value, in: array, range: middle..<range.upperBound)
    }
}

extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
        let range = range ?? startIndex..<endIndex
        
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2)
        
        if self[middle] == value  {
            return middle
        } else if value < self[middle] {
            return binarySearch(for: value, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
        }
    }
}
