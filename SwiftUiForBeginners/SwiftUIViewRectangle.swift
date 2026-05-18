//
//  SwiftUIViewRectangle.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 18/05/2026.
//

import SwiftUI

struct SwiftUIViewRectangle: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 300, height: 200, alignment: .center)
                .foregroundColor(.blue)
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 300, height: 200, alignment: .center)
                .foregroundColor(.blue)
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .frame(width: 300, height: 200, alignment: .center)
                .foregroundColor(.blue)
        }
      
    }
}

struct SwiftUIViewRectangle_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewRectangle()
    }
}
