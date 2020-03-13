import SwiftUI

struct DappView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading ,spacing: 8) {
                    Text("Mixin").font(.headline)
                        .padding(.leading, 16)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .center) {
                            Spacer()
                            ForEach(store.appState.dapps ?? []) { app in
                                DappItemView(model: app)
                            }
                            Spacer()
                        }
                    }
                    
                    Text("Fox.ONE").font(.headline)
                        .padding(.leading, 16)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .center) {
                            Spacer()
                            ForEach(store.appState.foxoneDapp ?? []) { app in
                                DappItemView(model: app)
                            }
                            Spacer()
                        }
                    }
                    
                    Text("Community")
                        .font(.headline)
                        .padding(.leading, 16)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .center) {
                            Spacer()
                            ForEach(store.appState.boxs ?? []) { app in
                                DappItemView(model: app)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct DappView_Previews: PreviewProvider {
    static var previews: some View {
        DappView()
    }
}
