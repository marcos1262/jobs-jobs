public struct JobsList: Equatable {
    public let offset: Int
    public let limit: Int
    public let totalCount: Int
    public let jobs: [Job]

    public init(offset: Int, limit: Int, totalCount: Int, jobs: [Job]) {
        self.offset = offset
        self.limit = limit
        self.totalCount = totalCount
        self.jobs = jobs
    }
}

extension JobsList: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(offset)
        hasher.combine(limit)
        hasher.combine(totalCount)
        hasher.combine(jobs)
    }
}
