import GraphViz

extension Node {
    public subscript<T>(dynamicMember member: WritableKeyPath<Attributes, T>) -> (T) -> Node {
        get {
            var mutableSelf = self
            return { newValue in
                mutableSelf[dynamicMember: member] = newValue
                return mutableSelf
            }
        }
    }
}
