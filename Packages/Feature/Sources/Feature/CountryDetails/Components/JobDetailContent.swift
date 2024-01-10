import SwiftUI
import DomainModels
import Utils

/// Content is a component of a page. Content accepts bindings or simple primitive types.
struct JobDetailContent: View {

    private let title: String
    private let detailsText: String

    init(title: String, detailsText: String) {
        self.title = title
        self.detailsText = detailsText
    }

    var body: some View {
        VStack {
            ScrollView {
                Text(detailsText)
                    .padding(10)
            }
        }
        .navigationBarTitle(title)
    }
}

struct JobDetailContent_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailContent(title: "iOS Engineer",
                         detailsText: "A very nice job")
    }
}
