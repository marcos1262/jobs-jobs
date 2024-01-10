public struct Job: Equatable {
    public let title: String

    public init(title: String) {
        self.title = title
    }
}

extension Job: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
