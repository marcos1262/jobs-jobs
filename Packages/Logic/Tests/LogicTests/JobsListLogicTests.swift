import Quick
import Nimble
import Swinject
import DomainModels
import CombineExpectations
import Interfaces
import InterfaceMocks
import RepositoriesMocks
import Combine
import Mockingbird

@testable import Logic

final class JobsListLogicTests: QuickSpec {

    override class func spec() {

        describe("JobsListLogic") {

            var sut: JobsListLogic!

            var container: Container!
            var jobsListRecorder: Recorder<JobsList?, Never>!
            var value: JobsList?
            var apiMock: JobsApiProtocolMock!

            beforeEach {
                container = Container()
                    .injectBusinessLogicRepositories()
                    .injectBusinessLogicLogic()
                    .injectInterfaceLocalMocks()
                    .injectInterfaceRemoteMocks()
                apiMock = (container.resolve(JobsApiProtocol.self)! as! JobsApiProtocolMock)

                sut = container.resolve(JobsListLogic.self)!

                jobsListRecorder = sut.$jobsList.record()
                value = try! QuickSpec.current.wait(for: jobsListRecorder.next(), timeout: 5.0)
            }

            it("starts with no jobsList") {
                expect(value).to(beNil())
            }

            describe("#getJobsList") {
                var recorder: Recorder<Void, JobsListError>!
                var completion: Subscribers.Completion<JobsListError>!

                beforeEach {
                    given(apiMock.getJobsList()).willReturn(.just(.fixture()))

                    recorder = sut.getJobsList().record()
                }

                context("success") {
                    beforeEach {
                        value = try! QuickSpec.current.wait(for: jobsListRecorder.next(), timeout: 5.0)
                        completion = try! QuickSpec.current.wait(for: recorder.completion, timeout: 5.0)
                    }

                    it("then value is set") {
                        expect(value) == .fixture()
                    }

                    it("then recorder has completed") {
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
            }
        }
    }
}
