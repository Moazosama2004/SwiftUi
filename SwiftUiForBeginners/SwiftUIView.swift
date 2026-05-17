//
//  SwiftUIView.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 17/05/2026.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("Hello,World Moaz , i think tou will enjoy with swiftui , let's do something different,Hello,World Moaz , i think tou will enjoy with swiftui , let's do something different,Hello,World Moaz , i think tou will enjoy with swiftui , let's do something different")
//            .font(.title)
//            .fontWeight(.bold)
//            .bold()
            .font(.system(size: 32, weight: .bold, design: .default))
//            .underline(color: .red)
//            .strikethrough(color: .blue)
//            .italic()
//            .multilineTextAlignment(.center)
//            .baselineOffset(-20)
//            .kerning(10)
//            .lineLimit(2)
            .border(.red, width: 2)
            .frame(width: 300, height: 300, alignment: .center)
            .border(.blue, width: 3)
            .minimumScaleFactor(0.5)
            .foregroundColor(.red)
        
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
