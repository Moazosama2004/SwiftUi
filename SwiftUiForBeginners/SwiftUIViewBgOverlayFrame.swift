//
//  SwiftUIViewBgOverlayFrame.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 21/05/2026.
//

import SwiftUI

struct SwiftUIViewBgOverlayFrame: View {
    var body: some View {
            Text("Bordered Button")
            .foregroundStyle(.red)
            .padding(EdgeInsets.init(top: 16, leading: 16, bottom: 16, trailing: 16))
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.yellow)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.red , lineWidth: 2)
            }
            .shadow(radius: 1)
            
    }
}

struct SwiftUIViewBgOverlayFrame_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewBgOverlayFrame()
    }
}
