//
//  SwiftUIViewGradient.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 19/05/2026.
//

import SwiftUI

struct SwiftUIViewGradient: View {
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .fill(
                    LinearGradient(colors: [.red,.green], startPoint: .top, endPoint: .bottom)
                ).frame(width: 100, height: 100, alignment: .center)
            
            Circle()
                .fill(
                    RadialGradient(colors: [.red,.blue], center: .center, startRadius: 20, endRadius: 50)
                ).frame(width: 100, height: 100, alignment: .center)
            
            Circle()
                .fill(
                    AngularGradient(colors: [.yellow,.blue], center: .center, angle:.degrees(0))
                ).frame(width: 100, height: 100, alignment: .center)
            
            Circle()
                .fill(
                    .linearGradient(colors: [.purple , .white], startPoint: .bottom, endPoint: .bottomTrailing)

                ).frame(width: 100, height: 100, alignment: .center)
            

            Circle()
                .fill(
                    AngularGradient(colors: [.yellow,.blue], center: .center, angle:.degrees(0))
                ).frame(width: 100, height: 100, alignment: .center)
        }
    }
}

struct SwiftUIViewGradient_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGradient()
    }
}
