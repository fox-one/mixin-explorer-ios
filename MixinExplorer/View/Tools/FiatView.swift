import SwiftUI

struct FiatView: View {
    @EnvironmentObject var store: Store
    
    var fiatsBinding: Binding<AppState.Fiats> {
        $store.appState.fiats
    }
    
    var body: some View {
        Group {
            if store.appState.fiats.loading && store.appState.fiats.fiat.isEmpty {
                HStack {
                    Spacer()
                    ActivityIndicator(shouldAnimate: fiatsBinding.loading)
                    Spacer()
                }
            } else {
                if !store.appState.fiats.fiat.isEmpty {
                    List {
                        ForEach(store.appState.fiats.fiat) { fiat in
                            HStack() {
                                Text(fiat.code)
                                Spacer()
                                Text("\(fiat.rate)")
                            }
                        }
                    }
                } else {
                    VStack(alignment: .center) {
                        EmptyView()
                    }
                }
            }
        }.navigationBarTitle("Fiat")
    }
}

struct FiatView_Previews: PreviewProvider {
    static var previews: some View {
        FiatView()
    }
}
