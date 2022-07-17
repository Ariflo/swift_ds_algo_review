import Foundation
enum Prim<Graph: DataStructures.Graph> where Graph.Element: Hashable {
    typealias Edge = Graph.Edge
    typealias Vertex = Edge.Vertex
    typealias MinimumSpanTree = AdjacencyList<Graph.Element>
    
    static func getMinimumSpanningTree(for graph: Graph) -> (cost: Double, minimumSpanTree: MinimumSpanTree) {
        var cost = 0.0
        var minimumSpanTree = MinimumSpanTree(verticies: graph.vertices)
        
        guard let start = graph.vertices.first else {
            return (cost, minimumSpanTree)
        }
        
        var visited = Set<Vertex>()
        var priorityQueue = PriorityQueue<Edge> { $0.weight < $1.weight }
        
        func enqueueAllAvaliableEdges(for source: Vertex) {
            graph.getEdges(from: source)
                .filter {
                    !visited.contains($0.destination)
                }
                .forEach {
                    priorityQueue.enqueue($0)
                }
        }
        
        visited.insert(start)
        enqueueAllAvaliableEdges(for: start)
        
        while let lightestEdge = priorityQueue.dequeue() {
            let destination = lightestEdge.destination
            
            guard !visited.contains(destination) else {
                continue
            }
            
            visited.insert(destination)
            cost += lightestEdge.weight
            minimumSpanTree.add(lightestEdge)
            
            enqueueAllAvaliableEdges(for: destination)
        }

        return (cost, minimumSpanTree)
    }
    
}
