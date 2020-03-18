import SwiftUI
import Kingfisher

struct DappBannerView: SwiftUI.View {
    var model: Banner
    var body: some SwiftUI.View {
        VStack(alignment: .leading, spacing: 2) {
            Text("News")
                .font(.callout)
                .foregroundColor(Color(.systemBlue))
                .lineLimit(1)
            Text(model.title)
                .font(.headline)
                .lineLimit(1)
            Text(model.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
            KFImage(URL(string: ""))
                          .placeholder {
                            SwiftUI.Image(model.iconURL)
                                  .resizable()
                                  .frame(width: imageSize.width, height: imageSize.height)
                                  .aspectRatio(contentMode: .fit)
                            .shadow(radius: 5)
                      }
                      .resizable()
                      .frame(width: imageSize.width, height: imageSize.height)
                      .cornerRadius(5)
                      .aspectRatio(contentMode: .fit)
                      .frame(alignment: .leading)
                 .shadow(radius: 5)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                      
        }.padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
        .onTapGesture {
            UIApplication.shared.open(URL(string: self.model.url)!, options: [:], completionHandler: nil)
        }
        .frame(width: itemWidth())
    }
    
    func itemWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width - 70
        return width
    }
    
    var imageSize: CGSize {
        let width = UIScreen.main.bounds.width - 40
        return CGSize(width: width, height: width * 0.5625)
    }
}

//struct DappBannerView_Previews: PreviewProvider {
//    static var previews: some SwiftUI.View {
//        DappBannerView()
//    }
//}
