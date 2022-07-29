class Node<Value> {
    var value: Value
    var next: Node<Value>?
    
    init(value: Value, next: Node<Value>? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) -> " + String(describing: next) + " "
    }
}
