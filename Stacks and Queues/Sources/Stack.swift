
struct Stack<Element: Equatable>: Equatable {
     static func == (lhs: Stack<Element>, rhs: Stack<Element>) -> Bool {
         lhs.storage == rhs.storage
     }

     private var storage = [Element]()

     var isEmpty: Bool  {
         return peek() == nil
     }

     init() {}

     init(_ elements: [Element]) {
         storage = elements
     }

     func peek() -> Element? {
         return storage.last
     }

     mutating func push(_ element: Element) {
         storage.append(element)
     }

     @discardableResult
     mutating func pop() -> Element? {
         return storage.popLast()
     }
 }

 extension Stack: CustomDebugStringConvertible {
     var debugDescription: String {
         return storage
             .map { "\($0)"}
             .joined(separator: " ")
     }
 }

 extension Stack: ExpressibleByArrayLiteral {
     init(arrayLiteral elements: Element...) {
         storage = elements
     }
 }
