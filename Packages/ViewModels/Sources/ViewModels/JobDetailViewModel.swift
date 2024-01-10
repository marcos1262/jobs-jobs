import DomainModels
import Combine

public class JobDetailViewModel: ObservableObject {

    @Published public var state: Job

    public init(job: Job) {
        self.state = job
    }
}
