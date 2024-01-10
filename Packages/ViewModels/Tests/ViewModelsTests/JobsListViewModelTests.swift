import Quick
import Nimble
import Swinject
import DomainModels
import CombineExpectations
import Interfaces
import InterfaceMocks
import Logic
import Combine
import Mockingbird
import RepositoriesMocks

@testable import ViewModels

final class JobsListViewModelTests: QuickSpec {

    override class func spec() {

        describe("JobsListViewModelTests") {

            var sut: JobsListViewModel!

            var container: Container!
            var api: JobsApiProtocolMock!
            let jobsListToBeReturned = PassthroughSubject<JobsListDTO, JobsApiError>()
            var stateRecorder: Recorder<JobsListViewModel.UiState, Never>!

            beforeEach {
                container = Container()
                    .injectBusinessLogicRepositories()
                    .injectBusinessLogicLogic()
                    .injectBusinessLogicViewModels()
                    .injectInterfaceLocalMocks()
                    .injectInterfaceRemoteMocks()
                api = (container.resolve(JobsApiProtocol.self)! as! JobsApiProtocolMock)

                given(api.getJobsList()).willReturn(jobsListToBeReturned.eraseToAnyPublisher())

                sut = container.resolve(JobsListViewModel.self)!
                stateRecorder = sut.$state.record()
            }

            it("starts having transitioned to .loading") {
                expect(try! stateRecorder.availableElements.get()) == [.loading]
            }

            context("when a jobList is returned") {
                var states: [JobsListViewModel.UiState]!

                beforeEach {
                    jobsListToBeReturned.send(.fixture())
                    jobsListToBeReturned.send(completion: .finished)

                    states = try! stateRecorder.availableElements.get()
                }

                it("then we should emit a loading and a loaded state") {
                    let expectedState = JobsListViewModel.UiState.ready(jobs: [.fixture()])
                    expect(states) == [.loading, expectedState]
                }
            }
        }
    }
}
