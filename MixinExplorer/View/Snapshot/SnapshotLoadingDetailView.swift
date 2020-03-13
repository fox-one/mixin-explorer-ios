import SwiftUI
import Kingfisher

struct SnapshotLoadingDetailView: SwiftUI.View {
    @EnvironmentObject var store: Store
    
    var settings: Binding<AppState.CurrentSnapShot> {
        $store.appState.currentSnapShot
    }
    
    var setting: AppState.CurrentSnapShot {
        store.appState.currentSnapShot
    }
    
    
    fileprivate func ItemList(title: LocalizedStringKey, value: String) -> some SwiftUI.View {
        Group {
            VStack(spacing: 8) {
                     Text(title)
                         .font(Font.system(size: 15))
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .foregroundColor(Color(.secondaryLabel))
                         .lineLimit(1)
                     Text(value)
                         .font(Font.system(size: 15))
                         .frame(maxWidth: .infinity,alignment: .leading)
                         .foregroundColor(Color(.label))
                 }
                 Divider()
        }
    }
    
    var body: some SwiftUI.View {
        Group {
            if setting.loadingSnapShot {
                ActivityIndicator(shouldAnimate: settings.loadingSnapShot)
            } else {
                if store.appState.currentSnapShot.snapshot == nil {
                    EmptyView()
                } else {
                    VStack(spacing: 5) {
                        VStack(alignment: .center, spacing: 8) {
                            KFImage(URL(string: store.appState.currentSnapShot.snapshot!.asset.iconURL))
                                .placeholder{
                                    SwiftUI.Image("placeholder")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .aspectRatio(contentMode: .fit)
                            }
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(15)
                            .aspectRatio(contentMode: .fit)
                            
                            Text("\(store.appState.currentSnapShot.snapshot!.asset.name)")
                                .font(Font.system(size: 18))
                                .foregroundColor(Color(.label))
                                .padding(8)
                        }
                        
                        VStack(spacing: 6) {
                            VStack {
                                Text("Snapshot ID:")
                                    .frame(alignment: .leading)
                                    .font(Font.system(size: 14))
                                    .foregroundColor(Color(.secondaryLabel))
                                Button("\(store.appState.currentSnapShot.snapshot!.snapshotID)") {
                                               UIPasteboard.general.string = self.store.appState.currentSnapShot.snapshot!.snapshotID
                                               postNoti(subtitle: self.store.appState.currentSnapShot.snapshot!.snapshotID)
                                }
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(Color(.label))
                                    .font(Font.system(size: 14))
                            }
                            
                            ItemList(title: "Amount:", value: "\(store.appState.currentSnapShot.snapshot!.amount) \(store.appState.currentSnapShot.snapshot!.asset.symbol)")
                            
                           ItemList(title: "Source:", value: "\(store.appState.currentSnapShot.snapshot!.source)")
                            ItemList(title: "Time:", value: " \(store.appState.currentSnapShot.snapshot!.date.timeString)")
                            
                            
                            Spacer()
                        }
                    }
                }
            }
        }.padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
        
    }
}



