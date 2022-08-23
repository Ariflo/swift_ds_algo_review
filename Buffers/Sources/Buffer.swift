struct RingBuffer<T> {
    fileprivate var array: [T?]
    fileprivate var readIndex = 0
    fileprivate var writeIndex = 0
    
    init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }
    
    var first: T? {
        array[readIndex]
    }
    
    fileprivate var avaliableSpaceForReading: Int {
        return writeIndex - readIndex
    }
    
    fileprivate var isEmpty: Bool {
        return avaliableSpaceForReading == 0
    }
    
    fileprivate var avaliableSpaceForWriting: Int {
        return array.count - avaliableSpaceForReading
    }
    
    var isFull: Bool {
        return avaliableSpaceForWriting == 0
    }
    
    @discardableResult
    mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    @discardableResult
    mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
}

extension RingBuffer: CustomStringConvertible {
    var description: String {
        let values = (0..<avaliableSpaceForReading).map {
            String(describing: array[($0 + readIndex) % array.count]!)
        }
        
        return "[" + values.joined(separator: ", ") + "]"
    }
}




