import SwiftUI
import Utils
import Combine
import UIComponents
import DomainModels
import ViewModels

public struct JobsListAdapter: View {

    @InjectStateObject private var viewModel: JobsListViewModel

    private var onJobSelected: ((Job) -> Void)?
    private var onAboutThisAppSelected: (() -> Void)?

    public init(onJobSelected: ((Job) -> Void)? = nil,
                onAboutThisAppSelected: (() -> Void)? = nil) {
        self.onJobSelected = onJobSelected
        self.onAboutThisAppSelected = onAboutThisAppSelected
    }

    public var body: some View {
        JobsListPage(listUiState: viewModel.state,
                     onItemTapped: { job in
            viewModel.onJobSelected(job)
        }, onAboutThisAppSelected: {
            onAboutThisAppSelected?()
        })
        .onReceive(viewModel.$navigationDestination, perform: { job in
            guard let job = job else { return }

            onJobSelected?(job)

            viewModel.navigationDestination = nil
        })
        .pss_notify(item: $viewModel.error, alertBuilder: {
            $0.asFloatingAlert()
        })
    }
}
