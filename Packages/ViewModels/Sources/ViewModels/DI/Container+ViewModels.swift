import Swinject
import Interfaces
import SwinjectAutoregistration

public extension Container {

    func injectBusinessLogicViewModels() -> Container {
        self.autoregister(JobsListViewModel.self, initializer: JobsListViewModel.init).inObjectScope(.transient)
        self.register(JobDetailViewModel.self) { resolver, job in
            JobDetailViewModel(job: job)
        }.inObjectScope(.transient)

        return self
    }
}
