import Swinject
import SwinjectAutoregistration

public extension Container {

    func injectBusinessLogicLogic() -> Container {
        self.autoregister(JobsListLogic.self, initializer: JobsListLogic.init).inObjectScope(.transient)

        return self
    }
}
