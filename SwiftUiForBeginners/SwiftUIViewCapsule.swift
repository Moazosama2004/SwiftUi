//
//  SwiftUIViewCapsule.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 18/05/2026.
//

import SwiftUI

struct SwiftUIViewCapsule: View {
    var body: some View {
        VStack(spacing: 100) {
            Capsule(style: .circular)
    //            .foregroundColor(.blue)
                .fill(.blue)
    //            .stroke(.green , style: StrokeStyle(lineWidth: 10, lineCap: .butt, dash: [30]))
                .frame(width: 300, height: 100, alignment: .center)
            Text("Next")
                .foregroundColor(.white)
                .font(.system(size: 32, weight: .regular, design: .default))
                .background {
                    Capsule(style: .circular)

                        .fill(.blue)
            //            .stroke(.green , style: StrokeStyle(lineWidth: 10, lineCap: .butt, dash: [30]))
                        .frame(width: 300, height: 100, alignment: .center)
                }
        }
        
        
       
    }
}

struct SwiftUIViewCapsule_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewCapsule()
    }
}
