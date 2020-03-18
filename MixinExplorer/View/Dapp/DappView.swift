import SwiftUI

struct DappView: View {
    @EnvironmentObject var store: Store
    
    
    var dapps: Dapps? {
        store.appState.dapp
    }
    
    func section(sec: DappSection) -> some SwiftUI.View {
        Group {
            Divider().padding(.leading).padding(.trailing)
            Text(sec.title)
                .font(.system(size: 22, weight: .bold))
                .padding(.leading, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(sec.data) { app in
                            DappItemView(model: app)
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            Divider().padding(.leading).padding(.trailing)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(dapps!.banner) { banner in
                                DappBannerView(model: banner)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            }
                        }
                    }
                    
                    ForEach(dapps!.section) { sec in
                        self.section(sec: sec)
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
