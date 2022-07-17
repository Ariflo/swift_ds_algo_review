import CloudKit
import Metal


//Bubble Sort
func bubbleSort<Element: Comparable>(_ array: inout [Element]) {
    guard array.count >= 2 else { return }
    
    for end in (0..<array.count).reversed() {
        var swapped = false
        
        for current in 0..<end  {
            if array[current] > array[current + 1] {
                array.swapAt(current, current + 1)
                swapped = true
            }
        }
        
        if !swapped {
            return
        }
    }
}


//TODO: Selection Sort
func selectionSort<Element: Comparable>(_ array: inout [Element]) {
    guard array.count >= 2 else { return }
    
    for current in 0..<(array.count - 1) {
        var lowest = current
        
        for other in (current + 1)..<array.count {
            if array[lowest] > array[other] {
                lowest = other
            }
        }
        
        if lowest != current {
            array.swapAt(lowest, current)
        }
    }
}


//TODO: Insertion Sort
func insertionSort<Element: Comparable>(_ array: inout [Element]) {
    guard array.count >= 2 else { return }
    
    for current in 1..<array.count {
        for shifting in (1...current).reversed() {
            if array[shifting] < array[shifting - 1] {
                array.swapAt(shifting, shifting - 1)
            }
        }
    }
}

