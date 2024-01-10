import Combine
import DomainModels
import Logic

public final class JobsListViewModel: ObservableObject {

    public enum UiState: Equatable {
        case loading
        case error(error: JobsListError)
        case ready(jobs: [Job])
    }

    @Published public var state: UiState = .loading
    @Published public var navigationDestination: Job?
    @Published public var error: JobsListError? = nil

    private var cancellables = Set<AnyCancellable>()
    private let logic: JobsListLogic

    public init(logic: JobsListLogic) {
        self.logic = logic

        logic.$jobsList
            .sink(receiveValue: { [weak self] jobsList in
                guard let jobsList = jobsList else { return }
                self?.state = .ready(jobs: jobsList.jobs)
            })
            .store(in: &cancellables)

        onPageLoaded()
    }

    private func onPageLoaded() {
        logic.getJobsList()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.state = .loading
            }, receiveCancel: { [weak self] in
                self?.state = .error(error: .notAvailable)
            })
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error: error)
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }

    public func onJobSelected(_ job: Job) {
        navigationDestination = job
    }
}
