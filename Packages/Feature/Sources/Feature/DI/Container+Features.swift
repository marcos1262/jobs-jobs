import Swinject
import SwinjectAutoregistration
import Interfaces

public extension Container {

    func injectBusinessLogicLocalApis() -> Container {
        self.autoregister(AppSchedulerProviding.self, initializer: AppSchedulerProvider.init).inObjectScope(.container)

        return self
    }
}
