import SwiftUI

struct AboutPage: View {

    var body: some View {
        VStack(spacing: 40) {
            Text("Simple jobs listing app using Clean MVVM Architecture from Perry Street Software")
            HStack {
                Text("Jobs Listing from")
                Link("himalayas.app", destination: URL(string: "https://himalayas.app")!)
            }
        }
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
