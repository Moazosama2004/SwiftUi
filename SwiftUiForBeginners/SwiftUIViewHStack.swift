//
//  SwiftUIViewHStack.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 21/05/2026.
//

import SwiftUI

struct SwiftUIViewHStack: View {
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 10) {
                
                VStack(
                    spacing: 50
                ){
                    ForEach(1...3 , id: \.self) {_ in
                        Circle()
                            .fill(.blue)
                            .frame(width: 50 , height: 25, alignment: .center)
                        
                    }
                }
                
                Circle()
                    .fill(.blue)
                    .frame(width: 200 , height: 200, alignment: .center)
                
                Spacer()
                
                Circle()
                    .fill(.blue)
                    .frame(width: 100 , height: 50, alignment: .center)
                
                Circle()
                    .fill(.blue)
                    .frame(width: 50 , height: 25, alignment: .center)
        }
    }
}

struct SwiftUIViewHStack_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewHStack()
    }
}
