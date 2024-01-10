import SwiftUI
import Utils
import DomainModels
import UIComponents

public struct JobsListView: View {

    var jobs: [Job]

    private var onItemTapped: ((Job) -> Void)?
    private var onAboutThisAppSelected: (() -> Void)?

    public init(jobs: [Job], 
                onItemTapped: ((Job) -> Void)? = nil,
                onAboutThisAppSelected: (() -> Void)? = nil) {
        self.jobs = jobs
        self.onItemTapped = onItemTapped
        self.onAboutThisAppSelected = onAboutThisAppSelected
    }

    public var body: some View {
        List {
            ForEach(jobs, id: \.self) { job in
                Text(job.title).onTapGesture {
                    onItemTapped?(job)
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle("Jobs")
        .toolbar {
            Button(action: {
                onAboutThisAppSelected?()
            }) {
                Image(systemName: "info.circle")
            }
        }
    }
}

struct JobsListView_Previews: PreviewProvider {
    static var previews: some View {
        JobsListView(jobs: [
            Job(title: "iOS Engineer"),
            Job(title: "Data Scientist"),
            Job(title: "Product Designer")
        ])
        .environment(\.locale, .init(identifier: "es"))
    }
}
