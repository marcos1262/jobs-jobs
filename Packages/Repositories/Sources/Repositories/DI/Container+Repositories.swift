import Swinject
import Interfaces
import SwinjectAutoregistration

public extension Container {

    func injectBusinessLogicRepositories() -> Container {
        self.autoregister(JobsListRepository.self, initializer: JobsListRepository.init).inObjectScope(.container)

        return self
    }
}
