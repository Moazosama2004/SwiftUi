//
//  SwiftUIViewAsyncImage.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 21/05/2026.
//

import SwiftUI

struct SwiftUIViewAsyncImage: View {
    let url = URL(string: "https://picsum.photos/400")
    
    var body: some View {
        AsyncImage(
            url: url
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 100)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()

            case .failure(_):
                Image(systemName: "photo.slash")
                    .foregroundStyle(.red)

            @unknown default:
                EmptyView()
            }
        }
    }
}

struct SwiftUIViewAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewAsyncImage()
    }
}
