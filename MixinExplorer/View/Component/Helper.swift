import Foundation
import SwiftUI

func ItemList(title: LocalizedStringKey, value: String) -> some SwiftUI.View {
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

func HItemList(title: LocalizedStringKey, value: String) -> some SwiftUI.View {
    Group {
        HStack(spacing: 8) {
            Text(title)
                .font(Font.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(.label))
                .lineLimit(1)
            Text(value)
                .font(Font.system(size: 16))
                .frame(maxWidth: .infinity,alignment: .trailing)
                .foregroundColor(Color(.label))
            .lineLimit(1)
        }
    }
}
