//
//  SwiftUIViewButtons.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 23/05/2026.
//

import SwiftUI

struct SwiftUIViewButtons: View {
    var body: some View {
        VStack(spacing: 20) {
            // this type of buttons is depand on what platforms runs this code .
            Button("Automatic Title") {
                print("Automatic Title")
            }
            .font(.title)
            .buttonStyle(.automatic)
            .tint(.red)
            
            // Borderd button Style
            Button("Bordered Title") {
                print("Bordered Title")
            }
            .font(.title)
            .buttonStyle(.bordered)
            .foregroundStyle(.blue)
            .tint(.red)
            
            
            Button("BorderedProminent Title") {
                print("BorderedProminent Title")
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.green)
            .tint(.red)
            
            
            // this type no depand on platform this will be identical on all platforms
            Button("Borderedless Title") {
                print("Borderedless Title")
            }
            .font(.title)
            .buttonStyle(.borderless)
            
            // this type changes style depand on what theme is on now
            Button("Plain Title") {
                print("Plain Title")
            }
            .font(.title)
            .buttonStyle(.plain)
            
            Button("CustomButtonStyle Title") {
                print("Custom Title")
            }
            .font(.title)
            .buttonStyle(CustomButtonStyle())
            
            
            Button("BorderedProminent Title") {
                print("BorderedProminent Title")
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.green)
            .tint(.red)
//            .disabled(true)
            .controlSize(.large)
            .buttonBorderShape(.capsule)
            
            
            Button {
                print("custom button with label")
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "photo.fill")
                        .font(.title)
                    Text("Upload Image")
                        .font(.title)
                        .bold()
                }
            }
            
            Button {
                print("custom button with label")
            } label: {
                 Image(systemName: "photo.fill")
//                        .font(.title)
            }
            .buttonStyle(.bordered)
//            .tint(.red)
            
            Button {
                print("custom button with label")
            } label: {
                 Circle()
                    .fill(.white)
                    .frame(width: 50, height: 50)
                    .shadow(radius: 10)
                    .overlay {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                    }
            }
//            .tint(.red)
   

        }
    }
}


struct SwiftUIViewButtons_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewButtons()
    }
}

struct CustomButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .foregroundColor(.black)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.red)
            )
    }
}
