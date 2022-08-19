class Node<Value> {
    var value: Value
    var next: Node<Value>?
    var previous: Node<Value>?
    
    init(value: Value){
        self.value = value
    }
}

extension Node:CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) -> " + String(describing: next) + " "
    }
}
