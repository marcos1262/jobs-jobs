import Combine
import DomainModels
import Interfaces

@testable import Repositories

public extension JobsListDTO {
    static func fixture(offset: Int = 0,
                        limit: Int = 10,
                        totalCount: Int = 100,
                        jobs: [JobDTO] = [.fixture()]) -> JobsListDTO {
        JobsListDTO(offset: offset, limit: limit, totalCount: totalCount, jobs: jobs)
    }
}

public extension JobDTO {
    static func fixture(title: String = "Software Engineer") -> JobDTO {
        JobDTO(title: title)
    }
}

public extension JobsList {
    static func fixture(offset: Int = 0,
                        limit: Int = 10,
                        totalCount: Int = 100,
                        jobs: [Job] = [.fixture()]) -> JobsList {
        JobsList(offset: offset, limit: limit, totalCount: totalCount, jobs: jobs)
    }
}

public extension Job {
    static func fixture(title: String = "Software Engineer") -> Job {
        Job(title: title)
    }
}
