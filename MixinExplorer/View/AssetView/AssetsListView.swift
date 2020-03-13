import SwiftUI

struct AssetsListView: View {
    @EnvironmentObject var store: Store
    var settings: AppState.TopAssetList {
        store.appState.topAsset
    }
    
    var settingsBinding: Binding<AppState.TopAssetList> {
        $store.appState.topAsset
    }
    
    var body: some View {
        Group {
            if store.appState.topAsset.loading {
                ActivityIndicator(shouldAnimate: settingsBinding.loading)
            } else {
                List {
                    ForEach(store.appState.topAsset.asset) { asset in
                        NavigationLink(destination: AssetDetailView(model: asset)) {
                            AssetRowView(model: asset)
                        }
                    }
                }
            }
        }
    }
}

struct AssetsListView_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        let store = Store()
        let assets = [Asset(amount: "100.0", assetID: "BTC", iconURL: "", symbol: "BTC", type: "abc"), Asset(amount: "100.0", assetID: "ETH", iconURL: "", symbol: "ETH", type: "abc")]
        
        store.appState.mixinNetworkAssetList.assets = assets
        return Group {
            AssetsListView().environmentObject(store)
        }
    }
}


//    func containedView() -> AnyView {
//        switch settings.exploreType {
//        case .topAsset:
//            return AnyView( List {
//                ForEach(store.appState.topAsset.asset) { asset in
//                    NavigationLink(destination: AssetDetailView(model: asset)) {
//                        MixinAssetRow(model: asset)
//                    }
//
//                }
//            })
//        case .chain:
//            return AnyView(List {
//                ForEach(store.appState.mixinNetworkAssetList.chains) { chain in
//                    NavigationLink(destination: MixinChainDetail(model: chain)) {
//                        MixinChainRow(model: chain)
//                    }
//
//                }
//            })
//        case .node:
//            return AnyView(
//                NodeListView()
//            )
//        case .dapp:
//            return AnyView(
//                Text("Dapp")
//            )
//        case .tool:
//            return AnyView(ToolView())
//        }
//    }

//struct OverLaySheet<Content: View>: View {
//    private let isPresented: Binding<Bool>
//    private let makeContent: () -> Content
//
//    init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping() -> Content) {
//        self.isPresented = isPresented
//        self.makeContent = content
//    }
//
//    var body: some View {
//        VStack {
//            Spacer()
//            makeContent()
//        }.offset(y: isPresented.wrappedValue ? 0: UIScreen.main.bounds.height)
//            .edgesIgnoringSafeArea(.bottom)
//    }
//}


//struct AssetHeader: View {
//    @EnvironmentObject var store: Store
//    var settings: AppState.Settings {
//        store.appState.settings
//    }
//    var body: some View {
//        ScrollView {
//            HStack (spacing: 12) {
//                Button("Top Assets") {
//                    self.store.dispatch(.toggleDisplay(type: .topAsset))
//                }.font(Font.system(size: 16, weight: settings.exploreType == .topAsset ? .bold : .regular ))
//                    .foregroundColor(settings.exploreType == .topAsset ? Color(.systemBlue) : Color(.systemGray))
//                    .frame(width: 90)
//
//                Button("Chain") {
//                    self.store.dispatch(.toggleDisplay(type: .chain))
//                }.font(Font.system(size: 16, weight: settings.exploreType == .chain ? .bold : .regular ))
//                    .foregroundColor(settings.exploreType == .chain ? Color(.systemBlue) : Color(.systemGray))
//                    .frame(width: 60)
//
//                Button("Node") {
//                    self.store.dispatch(.toggleDisplay(type:  .node))
//                }.font(Font.system(size: 16, weight: settings.exploreType == .node ? .bold : .regular ))
//                    .foregroundColor(settings.exploreType == .node ? Color(.systemBlue) : Color(.systemGray))
//                    .frame(width: 60)
//
//                //                Button("Dapp") {
//                //                    self.store.dispatch(.toggleDisplay(type:  .dapp))
//                //                }.font(Font.system(size: 16, weight: settings.exploreType == .dapp ? .bold : .regular ))
//                //                    .foregroundColor(settings.exploreType == .dapp ? Color(.systemBlue) : Color(.systemGray))
//                //                    .frame(width: 60)
//
//                Button("Tools") {
//                    self.store.dispatch(.toggleDisplay(type:  .tool))
//                }.font(Font.system(size: 16, weight: settings.exploreType == .tool ? .bold : .regular ))
//                    .foregroundColor(settings.exploreType == .tool ? Color(.systemBlue) : Color(.systemGray))
//                    .frame(width: 60)
//
//            }.frame(height: 35)
//        }
//    }
//}
