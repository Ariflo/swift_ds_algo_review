protocol Queue {
    associatedtype Element
    
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

//MARK: BoardGameManager
protocol BoardGameManager {

  associatedtype Player
  mutating func nextPlayer() -> Player?
}

//MARK: Deque
enum Direction {
  case front
  case back
}

protocol Deque {
  associatedtype Element
  var isEmpty: Bool { get }
  func peek(from direction: Direction) -> Element?
  mutating func enqueue(_ element: Element,
                        to direction: Direction) -> Bool
  mutating func dequeue(from direction: Direction) -> Element?
}

// MARK: QueueArray
struct QueueArray<T: Equatable>: Queue, Equatable {
    typealias Element = T
    private var array: [T] = []
    
    init() {}
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        
        return true
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
    
    var peek: T? {
        array.first
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
}

extension QueueArray {
    
    func reversed() -> QueueArray {
        var queue = self
        var stack = Stack<T>()
        
        while let element = queue.dequeue() {
            stack.push(element)
        }
        
        while let element = stack.pop() {
            queue.enqueue(element)
        }
        
        return queue
    }
}

extension QueueArray: BoardGameManager {
    mutating func nextPlayer() -> T? {
        guard let nextPlayer = dequeue() else {
            return nil
        }
        
        defer {
            enqueue(nextPlayer)
        }
        
        return nextPlayer
    }
    
    typealias Player = T
    
    
}

extension QueueArray: CustomStringConvertible {
    var description: String {
        String(describing: array)
    }
}

// MARK: QueueLinkedList
struct QueueLinkedList<T>: Queue {
    typealias Element = T
    private var list = DoublyLinkedList<T>()
    
    init() {}
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        list.append(element)
        
        return true
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        
        return list.remove(element)
    }
    
    var isEmpty: Bool {
        list.isEmpty
    }
    
    var peek: T? {
        list.first?.value
    }
}

extension QueueLinkedList: CustomStringConvertible {
    var description: String {
        String(describing: list)
    }
}

extension QueueLinkedList: Deque {
    func peek(from direction: Direction) -> T? {
        switch direction {
        case .back:
            list.last?.value
        case .front:
            peek
        }
        
    }
    
    @discardableResult
    mutating func enqueue(_ element: T, to direction: Direction) -> Bool {
        switch direction {
        case .back:
            enqueue(element)
        case .front:
            list.prepend(element)
        }
        return true
    }
    
    @discardableResult
    mutating func dequeue(from direction: Direction) -> T? {
        switch direction {
        case .back:
            guard !list.isEmpty, let element = list.last else {
                return nil
            }
            
            return list.remove(element)
        case .front:
            return dequeue()
        }
    }
    
    
}

// MARK: QueueRingBuffer
struct QueueRingBuffer<T>: Queue {
    typealias Element = T
    private var ringBuffer: RingBuffer<T>
    
    init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        ringBuffer.read()
    }
    
    var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    var peek: T? {
        ringBuffer.first
    }
}

extension QueueRingBuffer: CustomStringConvertible {
    var description: String {
        String(describing: ringBuffer)
    }
}

// MARK: QueueStack
struct QueueStack<T>: Queue {
    typealias Element = T
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    
    init(){}
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
    
    var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    var peek: T? {
        !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
}

extension QueueStack: CustomStringConvertible {
    var description: String {
        String(describing: leftStack.reversed() + rightStack)
    }
}




