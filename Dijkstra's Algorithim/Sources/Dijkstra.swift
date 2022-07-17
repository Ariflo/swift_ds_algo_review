import CloudKit
import Metal

enum Dijkstra<Graph: DataStructures.Graph> where Graph.Element: Hashable {
    typealias Edge = GraphEdge<Graph.Element>
    typealias Vertex = Edge.Vertex
    
    static func getEdges(alongPathFrom source: Vertex, in graph: Graph) -> [Vertex: Edge] {
        var edges = [Vertex: Edge]()
        
        func getWeight(to destination: Vertex) -> Double {
            return getShortestPath(to: destination, edgesAlongPath: edges)
                .map { $0.weight }
                .reduce(0, +)
        }
        
        var priorityQueue = PriorityQueue { getWeight(to: $0) < getWeight(to: $1) }
        priorityQueue.enqueue(source)
        
        while let vertex = priorityQueue.dequeue() {
            graph.getEdges(from: vertex)
                .filter {
                    $0.destination == source
                    ? false
                    : edges[$0.destination] == nil
                    || getWeight(to: vertex) + $0.weight < getWeight(to: $0.destination)
                }
                .forEach { newEdgeFromVertex in
                    edges[newEdgeFromVertex.destination] = newEdgeFromVertex
                    priorityQueue.enqueue(newEdgeFromVertex.destination)
                }
        }
        
        
        return edges
    }
    
    static func getShortestPath(to destination: Vertex, edgesAlongPath: [Vertex: Edge]) -> [Edge] {
        var shortestPath = [Edge]()
        
        var destination = destination
        
        while let edge = edgesAlongPath[destination] {
            shortestPath = [edge] + shortestPath
            destination = edge.source
        }
        
        return shortestPath
    }
    
    static func getShortestPath(from source: Vertex, to destination: Vertex, graph: Graph) -> [Edge] {
        return getShortestPath(to: destination, edgesAlongPath: getEdges(alongPathFrom: source, in: graph))
    }
}
