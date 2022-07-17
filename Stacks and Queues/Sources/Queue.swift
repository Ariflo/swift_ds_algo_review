protocol Queue {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
}

struct QueueArray<Element>: Queue {
    private var array = [Element]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var peek: Element? {
        return array.first
    }
    
    mutating func enqueue(_ element: Element) {
        array.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        return array.removeFirst()
    }
}

struct QueueStack<Element>: Queue {
    private var enqueueStack = [Element]()
    private var dequeueStack = [Element]()
    
    var isEmpty: Bool {
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    }
    
    var peek: Element? {
        return dequeueStack.isEmpty ? enqueueStack.first : dequeueStack.last
    }
    
    mutating func enqueue(_ element: Element) {
        enqueueStack.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.removeLast()
    }
}
