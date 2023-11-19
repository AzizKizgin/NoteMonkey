//
//  SplashScreen.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 19.11.2023.
//

import SwiftUI
struct SplashScreen: View {
    @State private var imageWidth: CGFloat = 0
    var body: some View {
        VStack{
            Image("icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageWidth)
                .foregroundStyle(.white)
                .onAppear{
                    DispatchQueue.main.async{
                        withAnimation(.smooth.speed(0.6)){
                            imageWidth = 200
                        }
                    }
                }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentColor)
    }
}

#Preview {
    SplashScreen()
}
