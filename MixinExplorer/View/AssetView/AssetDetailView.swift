import SwiftUI
import Kingfisher
import UserNotifications

struct AssetDetailView: SwiftUI.View {
    @EnvironmentObject var store: Store
    var settingsBinding: Binding<AppState.CurrentDetail> {
        $store.appState.snapDetail
    }
    
    var snapshotsBinding: Binding<AppState.SelectedAssetSnapshotList.LoadingSnapshots> {
        $store.appState.selectAssetSnapShotList.loadingSnapshots
    }
    
    let model: TopAsset
    var body: some SwiftUI.View {
        ScrollView {
            Divider()
            VStack(alignment: .center, spacing: 8) {
                HStack(alignment: .top) {
                    ZStack {
                        KFImage(URL(string: model.iconURL))
                            .placeholder{
                                SwiftUI.Image("placeholder")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .aspectRatio(contentMode: .fit)
                        }
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                        .aspectRatio(contentMode: .fit)
                        KFImage(getChainIcon())
                            .placeholder{
                                SwiftUI.Image("placeholder")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .aspectRatio(contentMode: .fit)
                        }
                        .resizable()
                        .frame(width: 15, height: 15)
                        .cornerRadius(6)
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 22, y: 22)
                    }
                    
                    VStack (spacing: 4) {
                        if store.appState.snapDetail.asset != nil {
                            HStack {
                                Text("Name:")
                                    .font(Font.system(size: 15))
                                    .foregroundColor(Color(.secondaryLabel))
                                    .lineLimit(1)
                                Text("\(store.appState.snapDetail.asset!.name)").frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Font.system(size: 15))
                                    .foregroundColor(Color(.label))
                            }
                            HStack {
                                Text("Amount:")
                                    .font(Font.system(size: 15))
                                    .foregroundColor(Color(.secondaryLabel))
                                    .lineLimit(1)
                                
                                Text("\(store.appState.snapDetail.asset!.amountValue.decimalFormatter) \(model.symbol)").frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Font.system(size: 15))
                                    .foregroundColor(Color(.label))
                            }
                            
                            //                            if store.appState.snapDetail.coin != nil {
                            HStack {
                                Text("Market Cap:")
                                    .font(Font.system(size: 15))
                                    .foregroundColor(Color(.secondaryLabel))
                                    .lineLimit(1)
                                Text("\(model.capitalization.decimalFormatter) USD")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Font.system(size: 15))
                                    .foregroundColor(Color(.label))
                            }
                            //                            }
                            
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                    
                }
                
                Text("Info").font(Font.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                if store.appState.snapDetail.asset != nil {
                    HStack {
                        Text("Asset ID:")
                            .font(Font.system(size: 15))
                            .foregroundColor(Color(.secondaryLabel))
                            .lineLimit(1)
                        Button("\(store.appState.snapDetail.asset!.assetID)") {
                            UIPasteboard.general.string = self.store.appState.snapDetail.asset!.assetID
                            postNoti(subtitle: self.store.appState.snapDetail.asset!.assetID)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(Font.system(size: 15))
                            .foregroundColor(Color(.label))
                            .lineLimit(1)
                    }
                    
                    //                    if store.appState.snapDetail.coin != nil {
                    HStack {
                        Text("Price:")
                            .font(Font.system(size: 15))
                            .foregroundColor(Color(.secondaryLabel))
                            .lineLimit(1)
                        Text("\(model.priceUSD) USD")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(Font.system(size: 15))
                            .foregroundColor(Color(.label))
                    }
                    
                    //                        HStack {
                    //                            Text("Max Supply:")
                    //                                .font(Font.system(size: 15))
                    //                                .foregroundColor(Color(.secondaryLabel))
                    //                                .lineLimit(1)
                    //                            Text("\(store.appState.snapDetail.coin!.coin.maxSupply)")
                    //                                .frame(maxWidth: .infinity, alignment: .trailing)
                    //                                .font(Font.system(size: 15))
                    //                                .foregroundColor(Color(.label))
                    //                        }
                    //                    }
                    

                    HStack {
                        Text("Snapshots Count:")
                            .font(Font.system(size: 15))
                            .foregroundColor(Color(.secondaryLabel))
                            .lineLimit(1)
                        Text("\(store.appState.snapDetail.asset!.snapshotsCount)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(Font.system(size: 15))
                            .foregroundColor(Color(.label))
                    }
                    
                    if store.appState.snapDetail.chain != nil {
                        NavigationLink(destination: MixinChainDetail(model: store.appState.snapDetail.chain!)) {
                            HStack {
                                Text("Chain:")
                                    .font(Font.system(size: 15))
                                    .foregroundColor(Color(.secondaryLabel))
                                    .lineLimit(1)
                                Text("\(store.appState.snapDetail.chain!.name)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .font(Font.system(size: 15))
                                    .foregroundColor(Color(.systemBlue))
                            }
                            
                        }
                        
                    } else {
                        ActivityIndicator(shouldAnimate: settingsBinding.loadingAsset)
                    }
                    
                    
                    
                } else {
                    ActivityIndicator(shouldAnimate: settingsBinding.loadingAsset)
                    
                }
                
                //                Text("Chain").font(Font.system(size: 16,weight: .bold))
                //                    .frame(maxWidth: .infinity, alignment: .leading)
                //                Divider()
                
                
                Text("Snapshots").font(Font.system(size: 17,weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                if store.appState.selectAssetSnapShotList.loadingSnapshots.loadingSnapShots {
                    ActivityIndicator(shouldAnimate: snapshotsBinding.loadingSnapShots)
                } else {
                    ScrollView {
                        SnapshotList()
                    }
                }
                
                
            }.padding(20)
            
        }.navigationBarTitle("\(model.symbol)").onAppear {
            if self.store.appState.snapDetail.asset != nil {
                if self.store.appState.snapDetail.asset!.assetID != self.model.assetId {
                    self.store.dispatch(.loadMixinAsset(assetID: self.model.assetId))
                }
            } else {
                self.store.dispatch(.loadMixinAsset(assetID: self.model.assetId))
            }
            
            if self.store.appState.selectAssetSnapShotList.snapshots.isEmpty {
                self.store.dispatch(.loadSnapshots(assetId: self.model.assetId))
                //                self.store.dispatch(.loadCoinMarket(symbol: self.model.symbol))
            }
        }
        
        
    }
        
    func getChainIcon() -> URL? {
        if let chain = store.appState.mixinNetworkAssetList.chainMap[model.chainId] {
            return URL(string: chain.iconURL)
        }
        return nil
    }
    
    func getAmountValue() -> String {
        var value: Double = 0
        
        if let asset = store.appState.mixinNetworkAssetList.assetMap[model.assetId] {
            value = asset.amountValue
        } else {
            value = model.amountValue
        }
        
        return value.decimalFormatter
    }
}

func postNoti(subtitle: String) {
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (success, error) in
         
     }
    
    
    let content = UNMutableNotificationContent()
   
    content.title = "Copied to Pasteboard"
    content.body = subtitle
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
    
    let request = UNNotificationRequest(identifier: "mixin.explore.noti", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { _ in
        
    }
}

//struct AssetDetail_Previews: PreviewProvider {
//    static var previews: some SwiftUI.View {
//        AssetDetailView(model: Asset(amount: "100.0",
//                                     assetID: "BTC",
//                                     iconURL: "",
//                                     symbol: "BTC",
//                                     type: "abc"))
//    }
//}


