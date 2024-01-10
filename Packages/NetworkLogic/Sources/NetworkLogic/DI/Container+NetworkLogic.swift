import Swinject
import Interfaces

public extension Container {

    func injectNetworkLogicRemoteApis() -> Container {
        self.register(JobsApiProtocol.self) { resolver in
            JobsApi(appScheduler: resolver.resolve(AppSchedulerProviding.self)!)
        }.inObjectScope(.container)

        return self
    }
}
