import SwiftUI
import Kingfisher

struct DappItemView: SwiftUI.View {
    let model: Dapp
    var body: some SwiftUI.View {
        HStack() {
            KFImage(URL(string: model.iconURL))
                .placeholder {
                    SwiftUI.Image("placeholder")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
            }
            .resizable()
            .frame(width: 60, height: 60)
            .cornerRadius(5)
            .aspectRatio(contentMode: .fit)
            .frame(alignment: .leading)
            .padding(0)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(model.title)
                    .foregroundColor(.primary)
                    .font(.system(size: 15))
                    .lineLimit(1)
                
                Text(model.subTitle)
                    .foregroundColor(.secondary)
                    .font(.system(size: 15))
                    .lineLimit(1)
                
            }
            Spacer()
        }
        .frame(width: itemWidth())
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .onTapGesture {
            UIApplication.shared.open(URL(string:self.model.url)!, options: [:], completionHandler: nil)
        }
    }
    
    func itemWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width - 40
        return width
    }
}

struct DappItemView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        DappItemView(model: Dapp(title: "12312asdasdadasdad312", subTitle: "123213", iconURL: "", url: ""))
    }
}
