import Interfaces
import Combine
import Foundation

public final class JobsApi: JobsApiProtocol {

    private let appScheduler: AppSchedulerProviding

    public init(appScheduler: AppSchedulerProviding) {
        self.appScheduler = appScheduler
    }

    public func getJobsList() -> AnyPublisher<JobsListDTO, JobsApiError> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "himalayas.app"
        components.path = "/jobs/api"
        components.queryItems = [
            URLQueryItem(name: "limit", value: "100"),
            URLQueryItem(name: "offset", value: "10")
        ]

        guard let url = components.url else {
            preconditionFailure("Failed to construct URL")
        }

        var task: URLSessionDataTask!

        return Deferred {
            Future<JobsListDTO, JobsApiError> { promise in
                task = URLSession.shared.dataTask(with: url) { data, response, error in

                    guard let httpResponse = response as? HTTPURLResponse else {
                        if let error: Error = error {
                            promise(.failure(JobsApiError.otherError(error)))
                        } else {
                            promise(.failure(JobsApiError.invalidResponseCode(.unknown)))
                        }

                        return
                    }

                    let apiResponseCode = ApiResponseCode(rawValue: httpResponse.statusCode)

                    if apiResponseCode == .success {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let decoded = try decoder.decode(JobsListDTO.self, from: data!)
                            promise(.success(decoded))
                        } catch {
                            promise(.failure(JobsApiError.otherError(error)))
                        }
                    } else {
                        promise(.failure(JobsApiError(statusCode: httpResponse.statusCode,
                                                      responseData: data)))
                    }
                }

                task.resume()
            }
        }
        .receive(on: appScheduler.mainScheduler)
        .delay(for: .seconds(1), scheduler: appScheduler.mainScheduler)
        .eraseToAnyPublisher()
    }
}
