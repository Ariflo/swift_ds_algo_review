//extension AdjacencyList: CustomStringConvertible {
//  var description: String {
//    return
//      adjacencies.mapValues { edges in
//        edges
//          .sorted { $0.destination.index < $1.destination.index }
//          .map { "\($0.destination.element) (\($0.weight))" }
//      }
//      .sorted { $0.key.index < $1.key.index }
//      .map {
//        let source = "\($0.key.index): \($0.key.element)"
//
//        guard !$0.value.isEmpty else {
//          return source
//        }
//
//        let sourceWithArrow = "\(source) -> "
//        return """
//          \(sourceWithArrow)\($0.value.joined(separator: "\n"
//            + String(repeating: " ", count: sourceWithArrow.count)
//          ))
//          """
//      }
//      .joined(separator: "\n\n")
//  }
//}
