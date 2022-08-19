struct SinglyLinkedList<Value: Equatable> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    init() {}
    
    var isEmpty:Bool {
        head == nil
    }
    
    mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    mutating func append(_ value: Value) {
        copyNodes()
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult
    mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        guard node !== tail else {
            append(value)
            
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    mutating func pop() -> Value? {
        copyNodes()
        defer {
            head = head?.next
            
            if isEmpty {
                tail = nil
            }
        }
        
        return head?.value
    }
    
    @discardableResult
    mutating func removeLast() -> Value? {
        copyNodes()
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        
        return current.value
    }
    
    @discardableResult
    mutating func remove(after node: Node<Value>) -> Value? {
        guard let node = copyNodes(returningCopyOf: node) else { return nil }
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else {
          return
        }
        
        guard var oldNode = head else {
            return
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
    mutating func reversed() -> String {
        var result: String = ""
        
        while let value = removeLast() {
            result += "\(value) "
        }
        
        return result
    }
    
    func getMiddleNode() -> Node<Value>? {
        var slow = head
        var fast = head
        
        while let nextFast = fast?.next {
            fast = nextFast.next
            slow = slow?.next
        }
        
        return slow
    }
    
    mutating func reverseList() {
        tail = head
        
        var prev = head
        var current = head?.next
        prev?.next = nil
        
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        
        head = prev
    }
    
    private mutating func copyNodes(returningCopyOf node: Node<Value>?) -> Node<Value>? {
        guard !isKnownUniquelyReferenced(&head) else {
            return nil
        }
        
        guard var oldNode = head else {
            return nil
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        var nodeCopy: Node<Value>?
        
        while let nextOldNode = oldNode.next {
            if oldNode === node {
                nodeCopy = newNode
            }
            
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        return nodeCopy
    }
    
    mutating func remove(all value: Value) {
        // Make sure to remove the value if it happens to be the value of the head
        while let headRef = head, headRef.value == value {
            head = headRef.next
        }
        
        var prev = head
        var current = head?.next
        
        while let currentNode = current {
            guard currentNode.value != value else {
                prev?.next = currentNode.next
                current = prev?.next
                continue
            }
            
            prev = current
            current = current?.next
        }
        
        tail = prev
    }
}

extension SinglyLinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}

extension SinglyLinkedList: Collection {
    
    struct Index: Comparable {
        var node: Node<Value>?
        
        static func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            
            let nodes = sequence(first: lhs.node) { $0?.next }
            
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    var startIndex: Index {
        Index(node: head)
    }
    
    var endIndex: Index {
        Index(node: tail?.next)
    }
    
    func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    subscript(position: Index) -> Value {
        position.node!.value
    }
}
