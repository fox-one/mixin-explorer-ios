import SwiftUI
import Kingfisher

struct DappItemView: SwiftUI.View {
    let model: Dapp
    var body: some SwiftUI.View {
        VStack(spacing: 4) {
            KFImage(URL(string: model.iconURL))
                .placeholder{
                    SwiftUI.Image("placeholder")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
            }
            .resizable()
            .frame(width: 50, height: 50)
            .cornerRadius(5)
            .aspectRatio(contentMode: .fit)
            .frame(alignment: .top)
            
            Text(model.title)
                .foregroundColor(.primary)
                .font(.caption)
                .lineLimit(1)
            
            Text(model.subTitle)
                .foregroundColor(.secondary)
                .font(.caption)
                .lineLimit(2)
            }
        .frame(width: 80)
        .padding(5)
        .onTapGesture {
                UIApplication.shared.open(URL(string:self.model.url)!, options: [:], completionHandler: nil)
        }
    }
}

struct DappItemView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        DappItemView(model: Dapp(title: "", subTitle: "", iconURL: "", url: ""))
    }
}
