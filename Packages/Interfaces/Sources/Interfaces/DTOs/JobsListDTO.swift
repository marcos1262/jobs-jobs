public struct JobsListDTO: Decodable {
    public let offset: Int
    public let limit: Int
    public let totalCount: Int
    public let jobs: [JobDTO]

    public init(offset: Int, limit: Int, totalCount: Int, jobs: [JobDTO]) {
        self.offset = offset
        self.limit = limit
        self.totalCount = totalCount
        self.jobs = jobs
    }
}
