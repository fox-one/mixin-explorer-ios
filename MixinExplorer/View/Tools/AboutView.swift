import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image("Icon")
                .cornerRadius(8)
                .padding(10)
            Text("Mixin Explorer")
            Text("Version \(Application.version)")
//            Button("Contact Developer") {
//                UIApplication.shared.open(URL(string: "mixin://users/e47fefc6-e673-423f-944f-97af9bcec5f3")!, options: [:], completionHandler: nil)
//            }
            Spacer()
        }
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
