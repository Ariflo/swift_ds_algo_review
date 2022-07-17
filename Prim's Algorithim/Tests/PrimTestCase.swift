import XCTest
@testable import DataStructures

final class PrimTestCase: XCTestCase {
    func test() {
        var graph = AdjacencyList<Int>()
        
        let one = graph.addVertex(1)
        let two = graph.addVertex(2)
        let three = graph.addVertex(3)
        let four = graph.addVertex(4)
        let five = graph.addVertex(5)
        let six = graph.addVertex(6)
        
        for edge in [
            // minimum spanning tree edges:
            GraphEdge(source: one, destination: three, weight: 1),
            GraphEdge(source: two, destination: three, weight: 5),
            GraphEdge(source: two, destination: five, weight: 3),
            GraphEdge(source: three, destination: six, weight: 4),
            GraphEdge(source: four, destination: six, weight: 2),
            
            // other edges:
            GraphEdge(source: one, destination: two, weight: 6),
            GraphEdge(source: one, destination: four, weight: 5),
            GraphEdge(source: three, destination: four, weight: 5),
            GraphEdge(source: three, destination: five, weight: 6),
            GraphEdge(source: five, destination: six, weight: 6)
        ] {
            graph.add(edge)
        }
        
        let (cost, minimumSpanningTree) = Prim.getMinimumSpanningTree(for: graph)
        XCTAssertEqual(cost, 15)
        XCTAssertEqual(
        "\(minimumSpanningTree)",
        """
        0: 1 -> 3 (1.0)
        
        1: 2 -> 3 (5.0)
                5 (3.0)
        
        2: 3 -> 1 (1.0)
                2 (5.0)
                6 (4.0)
        
        3: 4 -> 6 (2.0)
        
        4: 5 -> 2 (3.0)
        
        5: 6 -> 3 (4.0)
                4 (2.0)
        """
        )
    }
}
