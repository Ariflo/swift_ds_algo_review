import XCTest
@testable import DataStructures

final class TrieTestCase: XCTestCase {
    let trie = Trie<String>()
    
    func test_insert_contains() {
        trie.insert("cute")
        XCTAssertTrue(trie.contains("cute"))
        XCTAssertFalse(trie.contains("cut"))
    }
    
    func test_remove() {
        trie.insert("cut")
        trie.insert("cute")
        trie.insert("car")
        trie.insert("carry")
        
        XCTAssertTrue(trie.contains("cute"))
        XCTAssertTrue(trie.contains("cut"))
        XCTAssertTrue(trie.contains("car"))
        XCTAssertTrue(trie.contains("carry"))
        
        trie.remove("car")
        XCTAssertFalse(trie.contains("car"))
        XCTAssertTrue(trie.contains("cute"))
        XCTAssertTrue(trie.contains("carry"))
        XCTAssertTrue(trie.contains("cut"))
        
    }
    
    func test_prefixMatching() {
        trie.insert("car")
        trie.insert("card")
        trie.insert("care")
        trie.insert("cared")
        trie.insert("cars")
        trie.insert("carbs")
        trie.insert("carapace")
        trie.insert("cargo")
        
        let prefixedWithCar = trie.collections(startingWith: "car")
        XCTAssertEqual(prefixedWithCar.count, 8)
        
        let prefixedWithCare = trie.collections(startingWith: "care")
        XCTAssertEqual(prefixedWithCare.count, 2)
    }
    
    func test_collections() {
        trie.insert("car")
        trie.insert("card")
        trie.insert("care")
        trie.insert("cared")
        trie.insert("cars")
        trie.insert("carbs")
        trie.insert("carapace")
        trie.insert("cargo")
        
        XCTAssertEqual(trie.collections.sorted(), ["car", "carapace", "carbs", "card", "care", "cared", "cargo", "cars"])
        XCTAssertEqual(trie.collections.count, 8)
        XCTAssertFalse(trie.isEmpty)
    }
}
