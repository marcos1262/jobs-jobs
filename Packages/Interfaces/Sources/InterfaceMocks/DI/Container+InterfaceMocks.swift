import Swinject
import Mockingbird
import Interfaces
import Combine

public extension Container {
    func injectInterfaceRemoteMocks() -> Container {
        self.register(JobsApiProtocol.self) { resolver in
            mock(JobsApiProtocol.self)
        }.inObjectScope(.container)

        return self
    }

    func injectInterfaceLocalMocks() -> Container {
        self.register(AppSchedulerProviding.self) { resolver in
            MockAppSchedulerProviding()
        }.inObjectScope(.container)

        return self
    }
}
