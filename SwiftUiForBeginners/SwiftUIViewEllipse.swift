//
//  SwiftUIViewEllipse.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 18/05/2026.
//

import SwiftUI

struct SwiftUIViewEllipse: View {
    var body: some View {
        Ellipse()
//            .trim(from: 0.25, to: 0.99)
//            .fill(.red)
            .stroke(.blue , style: StrokeStyle(lineWidth: 20, lineCap: .butt, dash: [20]))
            .background {
                Text("Loading...")
                    .font(.system(size: 32,  design: .rounded))
            }
            .frame(width: 300, height: 400, alignment: .center)
//            .foregroundStyle(.blue)
            
    }
}

struct SwiftUIViewEllipse_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewEllipse()
    }
}
