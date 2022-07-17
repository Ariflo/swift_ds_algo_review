func mergeSort<Element: Comparable>(_ array: [Element]) -> [Element] {
    guard array.count > 1 else { return array }
    
    let middle = array.count / 2
    let leftArray = mergeSort(Array(array[..<middle]))
    let rightArray = mergeSort(Array(array[middle...]))
    
    return merge(leftArray, rightArray)
}

func merge<Element: Comparable>(_ left: [Element], _ right: [Element]) -> [Element] {
    var leftIndex = 0
    var rightIndex = 0
    var results = [Element]()
    
    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        
        if leftElement < rightElement {
            results.append(leftElement)
            leftIndex += 1
        } else if rightElement < leftElement {
            results.append(rightElement)
            rightIndex += 1
        } else {
            results.append(leftElement)
            leftIndex += 1
            results.append(rightElement)
            rightIndex += 1
        }
    }
    
    if leftIndex < left.count {
        results.append(contentsOf: left[leftIndex...])
    }
    
    if rightIndex < right.count {
        results.append(contentsOf: right[rightIndex...])
    }
    
    return results
}

