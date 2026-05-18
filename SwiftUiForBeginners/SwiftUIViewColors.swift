//
//  SwiftUIViewColors.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 18/05/2026.
//

import SwiftUI

struct SwiftUIViewColors: View {
    var body: some View {
        Circle()
//            .fill(Color.blue)
//            .fill(.blue)
//            .fill(Color(red: 0.2, green: 0.3, blue: 0.66,opacity: 0.5))
//            .fill(.primary) // adapt with apperances
//            .fill(Color(uiColor: .brown))
            .fill(Color("MyColor"))
    }
}

struct SwiftUIViewColors_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewColors()
            
    }
}
