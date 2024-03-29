import Foundation
import CombineSchedulers
import Combine
import Interfaces

public class MockAppSchedulerProviding: AppSchedulerProviding {
    public var useTestMainScheduler: Bool = false
    public var testScheduler: TestSchedulerOf<DispatchQueue> = DispatchQueue.test

    public var mainScheduler: AnySchedulerOf<DispatchQueue> {
        useTestMainScheduler ? testScheduler.eraseToAnyScheduler() : DispatchQueue.main.eraseToAnyScheduler()
    }
}
