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

func ValueItemList(title: LocalizedStringKey, value: String) -> some SwiftUI.View {
    Group {
        HStack(spacing: 8) {
            Text(title)
                .font(Font.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(.label))
                .lineLimit(1)
        HStack(alignment: .firstTextBaseline, spacing: 0.0) {
                Text(value)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(Font.custom("DINAlternate-Bold", size: 16))
                    .foregroundColor(Color(.secondaryLabel))
                Text(" USD")
                    .frame(alignment: .trailing)
                    .font(Font.system(size: 11, weight: .bold))
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
    }
}
