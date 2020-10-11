import GraphViz

extension Subgraph {
    typealias Fragment = SubgraphBuilder.Fragment

    public convenience init(id: String? = nil, @SubgraphBuilder _ builder: () -> SubgraphMember) {
        self.init(id: id)
        append(typeErased: builder())
    }

    private func append(_ fragment: Fragment) {
        for member in fragment.members {
            append(typeErased: member)
        }
    }

    private func append(typeErased member: SubgraphMember) {
        switch member {
        case let fragment as Fragment:
            append(fragment)
        case let node as Node:
            append(node)
        case let edge as Edge:
            append(edge)
        default:
            assertionFailure("unexpected member: \(member)")
            return
        }
    }

    public subscript<T>(dynamicMember member: WritableKeyPath<Attributes, T>) -> (T) -> Subgraph {
        get {
            var mutableSelf = self
            return { newValue in
                mutableSelf[dynamicMember: member] = newValue
                return mutableSelf
            }
        }
    }
}

public func Cluster(@SubgraphBuilder _ builder: () -> SubgraphMember) -> Subgraph {
    return Subgraph(id: "cluster", builder)
}
