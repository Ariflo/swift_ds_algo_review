class BinaryNode<Element> {
    var value: Element
    var leftChild: BinaryNode<Element>?
    var rightChild: BinaryNode<Element>?
    
    init(value: Element) {
        self.value = value
    }
}

extension BinaryNode {
    func traverseInOrder(_ visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit)
        visit(value)
        rightChild?.traverseInOrder(visit)
    }
    
    func traversePreOrder(_ visit: (Element?) -> Void) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.traversePreOrder(visit)
        } else { visit(nil) }
        
        if let rightChild = rightChild {
            rightChild.traversePreOrder(visit)
        } else { visit(nil) }
    }
    
    func traversePostOrder(_ visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit)
        rightChild?.traversePostOrder(visit)
        visit(value)
    }
}

extension BinaryNode: CustomStringConvertible {
  //Note: This algorithm is based on an implementation by Károly Lőrentey in his book Optimizing Collections, available from https://www.objc.io/books/optimizing-collections/.

  public var description: String {
    return diagram(for: self)
  }

  private func diagram(for node: BinaryNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.leftChild == nil && node.rightChild == nil {
      return root + "\(node.value)\n"
    }
    return diagram(for: node.rightChild,
                   top + " ", top + "┌──", top + "│ ")
      + root + "\(node.value)\n"
      + diagram(for: node.leftChild,
                bottom + "│ ", bottom + "└──", bottom + " ")
  }
}
