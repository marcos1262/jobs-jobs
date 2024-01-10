import SwiftUI
import Utils
import DomainModels
import UIComponents
import ViewModels

public struct JobsListPage: View {

    private let listUiState: JobsListViewModel.UiState
    private let onItemTapped: ((Job) -> Void)?
    private let onAboutThisAppSelected: (() -> Void)?

    public init(listUiState: JobsListViewModel.UiState,
                onItemTapped: ((Job) -> Void)? = nil,
                onAboutThisAppSelected: (() -> Void)? = nil) {
        self.listUiState = listUiState
        self.onItemTapped = onItemTapped
        self.onAboutThisAppSelected = onAboutThisAppSelected
    }

    public var body: some View {
        switch listUiState {
        case .loading:
            ProgressIndicator(isLoading: true)
        case .error:
            EmptyView()
        case .ready(let jobs):
            JobsListView(jobs: jobs,
                         onItemTapped: { job in
                onItemTapped?(job)
            }) {
                onAboutThisAppSelected?()
            }
        }
    }
}

struct JobListPage_Previews: PreviewProvider {
    static var previews: some View {
        let jobs = [
            Job(title: "iOS Engineer"),
            Job(title: "Data Scientist"),
            Job(title: "Product Designer")
        ]

        JobsListPage(listUiState: .ready(jobs: jobs))
    }
}
