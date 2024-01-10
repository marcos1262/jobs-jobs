import Combine
import Foundation

public protocol JobsApiProtocol {
    func getJobsList() -> AnyPublisher<JobsListDTO, JobsApiError>
}

public enum JobsDomainApiError: DomainApiError {
    case rateLimit

    /// Map network errors that will be handled by the app
    public init?(responseCode: ApiResponseCode, responseData: Data?) {
        switch responseCode {
        case .rateLimit:
            self = .rateLimit
        default:
            return nil
        }
    }
}

public typealias JobsApiError = ApiError<JobsDomainApiError>
