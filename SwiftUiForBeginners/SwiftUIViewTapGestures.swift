//
//  SwiftUIViewTapGestures.swift
//  SwiftUiForBeginners
//
//  Created by Moaz Osmaa on 26/05/2026.
//

import SwiftUI

struct SwiftUIViewTapGestures: View {
    @State private var circleColor = Color.blue
    var body: some View {
        Circle()
            .fill(circleColor)
            .frame(width: 200, height: 200)
//            .onTapGesture(count: 5){
//                circleColor = circleColor == .blue ? .red : .blue
//            }
            .gesture(TapGesture().onEnded({
                circleColor = circleColor == .blue ? .red : .blue
            }))
    }	 
}

#Preview {
    SwiftUIViewTapGestures()
}
