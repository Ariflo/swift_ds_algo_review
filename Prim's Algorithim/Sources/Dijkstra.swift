enum Dijkstra<Graph: DataStructures.Graph> where Graph.Element: Hashable {
  typealias Edge = Graph.Edge
  typealias Vertex = Edge.Vertex

  static func getEdges(alongPathsFrom source: Vertex, graph: Graph) -> [Vertex: Edge] {
    var edges: [Vertex: Edge] = [:]

    func getWeight(to destination: Vertex) -> Double {
      return getShortestPath(to: destination, edgesAlongPaths: edges)
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

  static func getShortestPath(to destination: Vertex, edgesAlongPaths: [Vertex: Edge]) -> [Edge] {
    var shortestPath: [Edge] = []
    var destination = destination
    while let edge = edgesAlongPaths[destination] {
      shortestPath = [edge] + shortestPath
      destination = edge.source
    }
    return shortestPath
  }

  static func getShortestPath(
    from source: Vertex, to destination: Vertex,
    graph: Graph
  ) -> [Edge] {
    return getShortestPath(
      to: destination,
      edgesAlongPaths: getEdges(alongPathsFrom: source, graph: graph)
    )
  }

  static func getShortestPaths(from source: Vertex, graph: Graph) -> [ Vertex: [Edge] ] {
    let edges = getEdges(alongPathsFrom: source, graph: graph)
    let paths = graph.vertices.map { getShortestPath(to: $0, edgesAlongPaths: edges) }
    return Dictionary( uniqueKeysWithValues: zip(graph.vertices, paths) )
  }
}
