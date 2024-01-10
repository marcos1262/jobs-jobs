import SwiftUI
import Utils
import DomainModels
import ViewModels
import Swinject

/// Adapters convert ViewModels into UIState objects
public struct JobDetailAdapter: View {

    @StateObject private var viewModel: JobDetailViewModel

    public init(job: Job, resolver: Resolver = InjectSettings.resolver!) {
        self._viewModel = StateObject(wrappedValue: resolver.resolve(JobDetailViewModel.self, argument: job)!)
    }

    public var body: some View {
        JobDetailPage(uiState: viewModel.state)
    }
}
