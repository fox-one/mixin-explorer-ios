import SwiftUI

struct EmptyView: View {
    var body: some View {
        Group {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "tray")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .colorMultiply(.secondary)
                
                Text("No Data")
                    .font(Font.system(size: 12))
            }.padding(4)
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
