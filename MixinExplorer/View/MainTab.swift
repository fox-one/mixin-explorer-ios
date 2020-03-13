import SwiftUI
import Combine

enum ExplorerType: Int {
    case topAsset = 0
    case dapp = 1
    case node = 2
    case tool = 3
    
    var title: LocalizedStringKey {
        switch self {
        case .topAsset:
            return "Mixin Explorer"
        case .dapp:
            return "Dapp"
        case .node:
            return "Node"
        case .tool:
            return "Tools"
        }
    }
}

final class MainTabBarData: ObservableObject {
    var tabType: ExplorerType
    
    let objectWillChange = PassthroughSubject<MainTabBarData, Never>()
    
    var itemSelected: Int {
        didSet {
            objectWillChange.send(self)
            tabType = ExplorerType(rawValue: 0) ?? ExplorerType.topAsset
            
        }
    }
    
    init(initialIndex: Int = 0) {
        self.itemSelected = initialIndex
        self.tabType = ExplorerType(rawValue: 0) ?? ExplorerType.topAsset
        
    }
}


struct MainTab: View {
    @EnvironmentObject var store: Store
    
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    
    @ObservedObject private var tabData = MainTabBarData(initialIndex: 0)
    
    var body: some View {
        NavigationView() {
            TabView(selection: self.$tabData.itemSelected) {
                AssetsListView()
                    .tabItem {
                        if self.tabData.itemSelected == 0 {
                            Image("tabBarIconSelected")
                        } else {
                            Image("tabBarIcon")
                        }
                        
                        Text("Top Assets")
                        
                }.tag(0)
                
                if self.isMixinInstall() {
                    DappView()
                        .tabItem {
                            if self.tabData.itemSelected == 1 {
                                Image(systemName: "gift")
                            } else {
                                Image(systemName: "gift")
                            }
                            Text("Dapp")
                    }.tag(1)
                }
                
                NodeView()
                    .tabItem {
                        if self.tabData.itemSelected == 2 {
                            Image(systemName: "hexagon")
                        } else {
                            Image(systemName: "hexagon")
                        }
                        Text("Node")
                }.tag(2)
                
                ToolView()
                    .navigationBarTitle("Tools")
                    .tabItem {
                        if self.tabData.itemSelected == 3 {
                            Image(systemName: "hammer")
                        } else {
                            Image(systemName: "hammer")
                        }
                        Text("Tools")
                }.tag(3)
            }
            .navigationBarTitle("Mixin Explorer")
            .edgesIgnoringSafeArea(.top)
            .modifier( WTF2(selection: self.$tabData.itemSelected) )
            
            
            EmptyView()
            
        }
        .sheet(isPresented: self.settingsBinding.showSnapshot.showSnapshot) {
            SnapshotLoadingDetailView().environmentObject(self.store)
        }
        .onAppear() {
            self.store.dispatch(.loadMixinNode)
            self.store.dispatch(.loadMixinTopAssets)
            self.store.dispatch(.loadMixinAssets)
        }
        .modifier( WTF() )
    }
    
    
    struct WTF: ViewModifier {
        func body(content: Content) -> some View  {
            Group {
                if UIDevice.current.orientation.isLandscape {
                    content
                        .navigationViewStyle(DoubleColumnNavigationViewStyle())
                } else {
                    content
                        .navigationViewStyle(StackNavigationViewStyle())
                }
            }
        }
    }
    
    struct WTF2<Int>: ViewModifier {
        let selection: Binding<Int>
        
        init(selection: Binding<Int>) {
            self.selection = selection
        }
        
        var title: LocalizedStringKey {
            if let value = self.selection.wrappedValue as? Swift.Int {
                return (ExplorerType(rawValue: value) ?? ExplorerType.topAsset).title
            } else {
                return "Mixin Explorer"
            }
        }
        
        func body(content: Content) -> some View  {
            Group {
                content.navigationBarTitle(self.title)
            }
        }
    }
    
    func isMixinInstall() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string:"mixin://")!)
    }
    
    private func leadingPadding(_ geometry: GeometryProxy) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 0.5
        }
        return 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store()
        return Group {
            MainTab().environmentObject(store)
        }
    }
}
