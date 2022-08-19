class Trie<CollectionType: Collection & Hashable> where CollectionType.Element: Hashable {
    typealias Node = TrieNode<CollectionType.Element>
    private let root = Node(key: nil, parent: nil)
    
    init() {}
    
    var collections = Set<CollectionType>()
    var isEmpty: Bool {
        collections.isEmpty
    }
    var count: Int {
        collections.count
    }
    
    func insert(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            if current.children[element] == nil  {
                current.children[element] = Node(key: element, parent: current)
            }
            current = current.children[element]!
        }
        current.isTerminating = true
        collections.insert(collection)
    }
    
    func contains(_ collection: CollectionType) -> Bool {
        var current = root
        
        for element in collection {
            guard let child = current.children[element] else {
                return false
            }
            current = child
        }
        return current.isTerminating
    }
    
    func remove(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            guard let child = current.children[element] else {
                return
            }
            current = child
        }
        
        guard current.isTerminating else {
            return
        }
        
        current.isTerminating = false
        collections.remove(collection)
        
        while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
            parent.children[current.key!] = nil
            current = parent
        }
    }
}

extension Trie where CollectionType: RangeReplaceableCollection {
    func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var current = root
        
        for element in prefix {
            guard let child = current.children[element] else {
                return []
            }
            current = child
        }
        
        return collections(startingWith: prefix, after: current)
    }
    
    func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
        
        var results = [CollectionType]()
        
        if node.isTerminating {
            results.append(prefix)
        }
        
        for child in node.children.values {
            var prefix = prefix
            prefix.append(child.key!)
            results.append(contentsOf: collections(startingWith: prefix, after: child))
        }
        
        return results
    }
}
