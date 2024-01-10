import DomainModels
import Combine
import Repositories

public class JobsListLogic {

    @Published public private(set) var jobsList: JobsList?

    private let jobsListRepository: JobsListRepository

    public init(jobsListRepository: JobsListRepository) {
        self.jobsListRepository = jobsListRepository
        self.jobsList = jobsListRepository.jobsList

        jobsListRepository.$jobsList
            .assign(to: &$jobsList)
    }

    public func getJobsList() -> AnyPublisher<Void, JobsListError> {
        return jobsListRepository.getJobsList().eraseToAnyPublisher()
    }
}
