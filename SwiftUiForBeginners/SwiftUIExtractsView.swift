//
//  SwiftUIExtractsView.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 23/05/2026.
//

import SwiftUI

struct SwiftUIExtractsView: View {
    @State private var counter = 0
    
    /*
    var backgroundGradient : some View {
        LinearGradient(
            colors: [.blue , .purple],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
    }
    */
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            VStack {
              
                AppTitle(label: "Counter")
                
                FinalResult(result: counter)

                
                HStack() {

                    AppButton(symbol: "-", color: .red) {
                        counter -= 1
                    }
                    
                    AppButton(symbol: "+", color: .green) {
                        counter += 1
                    }
                   
                }
            }
            
            
        }
        .ignoresSafeArea()
    }
}

struct SwiftUIExtractsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIExtractsView()
    }
}

struct BackgroundGradient: View {
    var body : some View {
        LinearGradient(
            colors: [.blue , .purple],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
    }
}

struct AppTitle : View {
    let label : String
    var body : some View {
        Text(label)
            .font(.largeTitle)
            .bold()
            .foregroundStyle(.white)
    }
}


struct FinalResult : View {
    let result : Int
    var body : some View {
        Text(String(result))
            .font(.system(size: 72, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .padding()
            .background {
                Circle()
                    .fill(.red)
            }
    }
}

struct AppButton : View {
    let symbol : String
    let color : Color
    let action : () -> Void
    var body : some View {
        Button (action: action) {
            Circle()
                .fill(.white)
                .frame(width: 60, height: 60)
                .shadow(radius: 2)	
                .overlay {
                    Text(symbol)
                        .foregroundStyle(color)
                        .font(.system(size: 62, weight: .bold, design: .rounded))
                        
                    
                }
        }
    }
}

