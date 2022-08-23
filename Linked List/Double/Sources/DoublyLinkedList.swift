class DoublyLinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    init() {}
    
    var isEmpty: Bool {
        head == nil
    }
    
    var first: Node<Value>? {
        head
    }
    
    var last: Node<Value>? {
        tail
    }
    
    func prepend(_ value: Value) {
        let newNode = Node(value: value)
        
        guard let headNode = head else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.previous = nil
        newNode.next = headNode
        headNode.previous = newNode
        
        head = newNode
    }
    
    func append(_ value: Value) {
        let newNode = Node(value: value)
        
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.previous = tailNode
        tailNode.next = newNode
        tail = newNode
    }
    
    
    func remove(_ node: Node<Value>) -> Value {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    var description: String {
        var string = ""
        var current = head
        while let node = current {
            string.append("\(node.value) -> ")
            current = node.next
        }
        return string + "end"
    }
}

class LinkedListIterator<Value>: IteratorProtocol {
    var current: Node<Value>?
    
    init(node: Node<Value>?) {
        current = node
    }
    
    func next() -> Node<Value>? {
        defer {
            current = current?.next
        }
        return current
    }
}

extension DoublyLinkedList: Sequence {
    func makeIterator() -> LinkedListIterator<Value> {
        LinkedListIterator(node: head)
    }
}
