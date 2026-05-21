//
//  SwiftUIViewZStack.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 21/05/2026.
//

import SwiftUI

struct SwiftUIViewZStack: View {
    let url = URL(string: "https://picsum.photos/400")
    var body: some View {
        
        VStack(
        spacing: 24
        ) {
            ZStack(
                alignment: .bottomLeading
            ) {
                AsyncImage(
                    url: url
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 300, height: 300)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(.blue, lineWidth: 5)
                            )

                    case .failure(_):
                        Image(systemName: "photo.slash")
                            .foregroundStyle(.red)

                    @unknown default:
                        EmptyView()
                    }
                }
                
                Circle()
                    .fill(.green)
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
            }
            
            Text("Moaz Osama")
                .font(.system(size: 32, weight: .regular, design: .rounded))
        }
        
        
        
//       VStack(
//       ) {
//           ZStack(
//               alignment: .center
//           ) {
//               Circle()
//                   .fill(.red)
//                   .frame(width: 200, height: 200, alignment: .center)
//               Text("1")
//                   .font(.system(size: 48, weight: .bold, design: .rounded))
//           }
//
//           Circle()
//               .fill(.red)
//               .frame(width: 200, height: 200, alignment: .center)
//               .overlay {
//                   Text("1")
//                       .font(.system(size: 48, weight: .bold, design: .rounded))
//               }
//
//
//           Text("1")
//               .font(.system(size: 48, weight: .bold, design: .rounded))
//               .background {
//                   Circle()
//                       .fill(.red)
//                       .frame(width: 200, height: 200, alignment: .center)
//               }
//       }
    }
}

struct SwiftUIViewZStack_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewZStack()
    }
}
