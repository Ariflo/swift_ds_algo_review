class SinglyLinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    init(){}
    
    var isEmpty: Bool {
        head == nil
    }
    
    var first: Node<Value>? {
        head
    }
    
    func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    func append(_ value: Value) {
        copyNodes()
        guard tail != nil else {
            push(value)
            return
        }
        
        tail?.next = Node(value: value)
        tail = tail?.next
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
    func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        guard node !== tail else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    func pop() -> Value? {
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
    func removeLast() -> Value? {
        copyNodes()
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var curr = head
        
        while let next = curr.next {
            prev = curr
            curr = next
        }
        
        prev.next = nil
        tail = prev
        
        return curr.value
    }
    
    @discardableResult
    func remove(after node: Node<Value>) -> Value? {
        guard let node = copyNodes(returningCopyOf: node) else {
            return nil
        }
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    private func copyNodes() {
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
    
    private func copyNodes(returningCopyOf node: Node<Value>) -> Node<Value>? {
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
    
    struct Index: Comparable {
        var node: Node<Value>?
        
        static func == (lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case nil, nil:
                return true
            default:
                return false
            }
        }
        
        static func < (lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
}
