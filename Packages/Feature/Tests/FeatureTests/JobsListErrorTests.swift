import Quick
import Nimble
import Swinject
import DomainModels
import Interfaces
import InterfaceMocks
import Logic
import Combine
import Mockingbird
import UIComponents

@testable import Feature

final class JobsListErrorTests: QuickSpec {

    override class func spec() {

        describe("JobsListError") {

            var container: Container!
            var api: JobsApiProtocolMock!
            let jobsListToBeReturned = PassthroughSubject<JobsListDTO, JobsApiError>()

            beforeEach {
                container = Container().injectBusinessLogicRepositories()
                    .injectBusinessLogicLogic()
                    .injectBusinessLogicViewModels()
                    .injectInterfaceLocalMocks()
                    .injectInterfaceRemoteMocks()

                api = (container.resolve(JobsApiProtocol.self)! as! JobsApiProtocolMock)

                given(api.getJobsList()).willReturn(jobsListToBeReturned.eraseToAnyPublisher())
            }

            it("Blocked error shows a dialog"){
                let floatingAlert = JobsListError.blocked.asFloatingAlert()

                switch floatingAlert {
                case .dialog(let state):
                    expect(state.title) == L10n.Errors.countryListBlockedErrorTitle
                case .toast(_):
                    fail("was expecting a dialog")
                }
            }
        }
    }
}
