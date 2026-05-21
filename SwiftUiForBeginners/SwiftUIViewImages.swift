//
//  SwiftUIViewImages.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 21/05/2026.
//

import SwiftUI

struct SwiftUIViewImages: View {
    var body: some View {
        VStack(spacing: 10) {
            // system icons
            Image(systemName: "pencil.tip.crop.circle.badge.plus")
    //            .font(.system(size: 100))
    //            .renderingMode(.original)
                .symbolRenderingMode(.palette)
                .resizable()
                .aspectRatio(contentMode: .fit)
    //            scaledToFill()
                .frame(width: 300, height: 300, alignment: .center)
            
    //            .clipped()
                .foregroundStyle(.blue , .yellow)
            
            // custom Images
            Image("app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
//                .cornerRadius(100)
                .clipShape(Circle())
//                .clipShape(RoundedRectangle(cornerRadius: 24))
                .clipped()
   
        }
    }
}

struct SwiftUIViewImages_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewImages()
    }
}
