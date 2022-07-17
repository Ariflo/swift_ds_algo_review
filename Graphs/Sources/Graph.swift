import Metal

protocol Graph {
    associatedtype Element
    
    typealias Edge = GraphEdge<Element>
    typealias Vertex = Edge.Vertex
    
    var verticies: [Vertex] { get }
    
    mutating func addVertex(_ element: Element) -> Vertex
    
    func getEdges(_ source: Vertex) -> [Edge]
    
}

struct GraphVertex<Element> {
    let index: Int
    let element: Element
}

extension GraphVertex: Equatable where Element: Equatable { }
extension GraphVertex: Hashable where Element: Hashable { }

struct GraphEdge<Element> {
    typealias Vertex = GraphVertex<Element>
    
    let source: Vertex
    let destination: Vertex
    let weight: Double
}

extension GraphEdge: Equatable where Element: Equatable { }
extension GraphEdge: Hashable where Element: Hashable { }

extension Graph where Element: Hashable {
    func getPaths(from source: Vertex, to destination: Vertex) -> Set<[Edge]> {
        var completedPaths = Set<[Edge]>()
        var activePaths = Set(getEdges(source).map { [$0] })
        
        while !activePaths.isEmpty {
            for path in activePaths {
                let pathend = path.last!.destination
                
                defer {
                    activePaths.remove(path)
                }
                
                if pathend == destination {
                    completedPaths.insert(path)
                    continue
                }
                
                getEdges(pathend)
                    .filter { pathEndEdge in
                        !path.map{ currentPathEdge in
                            currentPathEdge.source
                        }.contains(pathEndEdge.destination)
                    }
                    .forEach {
                        activePaths.insert(path + [$0])
                    }
            }
        }
        
        return completedPaths
    }
}
