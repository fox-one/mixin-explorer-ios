import SwiftUI

struct ToolView: View {
    var body: some View {
        Form {
            Section(header: Text("Search Mixin Network")) {
                NavigationLink(destination: SearchView()) {
                    Text("Search Snapshot")
                }
                
                NavigationLink(destination: SearchAssetView()) {
                    Text("Search Asset")
                }
                
                NavigationLink(destination: VerifyAssetView()) {
                    Text("Token Verify")
                }
                
                NavigationLink(destination: ChainListView()) {
                    Text("Chain")
                }
            }
            
            Section (header: Text("About")) {
                NavigationLink(destination: InfoView()) {
                    Text("About Mixin Network")
                }
                NavigationLink(destination: AboutView()) {
                    Text("About Mixin Explorer")
                }
            }
            
        }
    }
}

struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        ToolView()
    }
}
