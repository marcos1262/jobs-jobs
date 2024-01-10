import SwiftUI
import Swinject
import Interfaces
import Utils
import NetworkLogic
import Logic
import ViewModels
import Feature

@main
struct JobsJobsApp: App {

    init() {
        InjectSettings.resolver = Container()
            .injectBusinessLogicViewModels()
            .injectBusinessLogicLogic()
            .injectBusinessLogicRepositories()
            .injectBusinessLogicLocalApis()
            .injectNetworkLogicRemoteApis()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
