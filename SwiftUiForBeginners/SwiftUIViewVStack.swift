//
//  SwiftUIViewVStack.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 21/05/2026.
//

import SwiftUI

struct SwiftUIViewVStack: View {
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
                .frame(width: 300, height: 100, alignment: .center)
           
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .fill(.green)
                .frame(width: 200, height: 100, alignment: .center)
            
            HStack(){
                RoundedRectangle(cornerRadius: 10)
                    .fill(.yellow)
                    .frame(width: 100, height: 100, alignment: .center)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(.yellow)
                    .frame(width: 100, height: 100, alignment: .center)
            }
        }.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
    }
}

struct SwiftUIViewVStack_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewVStack()
    }
}
