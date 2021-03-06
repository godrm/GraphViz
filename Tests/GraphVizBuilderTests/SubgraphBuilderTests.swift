import XCTest
import GraphViz
@testable import DOT
@testable import GraphVizBuilder

// Workaround for "error: ambiguous reference to member '-->'" on Swift 5.1
#if swift(>=5.2)
final class SubgraphBuilderTests: XCTestCase {
    let encoder = DOTEncoder()
    let graph = Graph(directed: true, strict: true)

    func testSubgraph() {
        let subgraph = Subgraph(id: "hello") {
            "a" --> "b"
            "a" --> "c"
            "a" --> "d"
        }.rank(.same)

        let expected = """
        subgraph hello {
            rank=same
            a -> b
            a -> c
            a -> d
        }
        """

        XCTAssertEqual(encoder.encode(subgraph, in: graph), expected)
    }
}
#endif
