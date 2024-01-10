import SwiftUI
import Utils
import Combine
import DomainModels
import Feature
import Swinject

public struct JobsJobsNavHost: View {

    private let resolver: Resolver

    @State var destination: Destination?

    enum Destination {
        case jobDetail(_ job: Job)
        case about
    }

    public init(resolver: Resolver = InjectSettings.resolver!) {
        self.resolver = resolver
    }

    public var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: buildChildViewFromState(),
                    isActive: $destination.mappedToBool(),
                    label: {
                        EmptyView()
                    }
                )

                buildBaseView()
            }
        }
    }

    @ViewBuilder func buildBaseView() -> some View {
        JobsListAdapter(onJobSelected: { job in
            self.destination = .jobDetail(job)
        }) {
            self.destination = .about
        }
    }

    @ViewBuilder func buildChildViewFromState() -> some View {
        switch destination {
        case .jobDetail(let job):
            JobDetailAdapter(job: job)
        case .about:
            AboutAdapter()
        case .none:
            EmptyView()
        }
    }
}
