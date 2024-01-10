import SwiftUI
import DomainModels
import UIComponents

/// Pages represent the entire thing shown onscreen. Pages take UIState objects.
/// Pages are the top-most thing that we attempt to preview.
public struct JobDetailPage: View {

    var uiState: Job

    public init(uiState: Job) {
        self.uiState = uiState
    }

    public var body: some View {
        JobDetailContent(title: uiState.title,
                         detailsText: uiState.title)
    }
}

struct JobDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        let job = Job(title: "iOS Engineer")

        JobDetailPage(uiState: job)
    }
}
