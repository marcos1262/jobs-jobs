import Interfaces
import DomainModels
import Combine

public class JobsListRepository {

    @Published public private(set) var jobsList: JobsList?

    private let jobsListProvider: JobsApiProtocol

    public init(jobsListProvider: JobsApiProtocol) {
        self.jobsListProvider = jobsListProvider
    }

    public func getJobsList() -> AnyPublisher<Void, JobsListError> {
        jobsListProvider.getJobsList()
            .handleEvents(receiveOutput: { [weak self] jobsList in
                self?.jobsList = JobsList(offset: jobsList.offset,
                         limit: jobsList.limit,
                         totalCount: jobsList.totalCount,
                         jobs: jobsList.jobs.map { job in
                    Job(title: job.title)
                })
            })
            .map { _ in }
            .mapError { error in
                JobsListError.connectionError(innerError: error)
            }
        .eraseToAnyPublisher()
    }
}
