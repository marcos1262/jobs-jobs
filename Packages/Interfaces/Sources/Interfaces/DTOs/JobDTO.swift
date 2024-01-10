public struct JobDTO: Decodable {
    public let title: String

    public init(title: String) {
        self.title = title
    }
}
