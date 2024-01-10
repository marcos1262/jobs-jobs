import Quick
import Nimble
import Swinject
import DomainModels
import CombineExpectations
import Interfaces
import Combine
import Mockingbird
import InterfaceMocks
import RepositoriesMocks

@testable import Repositories

final class JobsListRepositoryTests: QuickSpec {

    override class func spec() {

        describe("JobsListRepository") {

            var sut: JobsListRepository!

            var container: Container!
            var api: JobsApiProtocolMock!
            var jobsListsRecorder: Recorder<JobsList?, Never>!
            var jobsList: JobsList?

            beforeEach {
                container = Container()
                    .injectBusinessLogicRepositories()
                    .injectInterfaceLocalMocks()
                    .injectInterfaceRemoteMocks()
                sut = container.resolve(JobsListRepository.self)!
                api = (container.resolve(JobsApiProtocol.self)! as! JobsApiProtocolMock)

                jobsListsRecorder = sut.$jobsList.record()
                jobsList = try! QuickSpec.current.wait(for: jobsListsRecorder.next(), timeout: 5.0)
            }

            it("starts with no jobsList") {
                expect(jobsList).to(beNil())
            }

            describe("#reload") {
                var recorder: Recorder<Void, JobsListError>!
                var completion: Subscribers.Completion<JobsListError>!

                context("success") {

                    justBeforeEach {
                        _ = try! QuickSpec.current.wait(for: recorder.next(), timeout: 5.0)
                        jobsList = try! QuickSpec.current.wait(for: jobsListsRecorder.next(), timeout: 5.0)
                        completion = try! QuickSpec.current.wait(for: recorder.completion, timeout: 5.0)
                    }

                    beforeEach {
                        given(api.getJobsList()).willReturn(.just(.fixture()))
                        recorder = sut.getJobsList().record()
                    }

                    it("sets value correctly") {
                        expect(jobsList) == .fixture()
                    }

                    it("recorder has completed") {
                        switch completion {
                        case .failure:
                            fail("Unexpected state")
                        case .finished:
                            // ok
                            break
                        case .none:
                            fail("Unexpected state")
                        }
                    }
                }

                context("failure") {

                    beforeEach {
                        given(api.getJobsList()).willReturn(.error(JobsApiError(statusCode: 10)))
                        recorder = sut.getJobsList().record()
                    }

                    justBeforeEach {
                        completion = try! QuickSpec.current.wait(for: recorder.completion, timeout: 5.0)
                    }

                    it("then recorder has failed") {
                        switch completion {
                        case .failure:
                            return
                        case .finished:
                            fail("Unexpected state")
                        case .none:
                            fail("Unexpected state")
                        }
                    }
                }
            }
        }
    }
}
