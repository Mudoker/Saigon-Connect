//
//  ContentView.swift
//  Saigon Connect
//
//  Created by Quoc Doan Huu on 18/07/2023.
//

import SwiftUI

struct welcomeScreen: View {
    
    @State private var showingAlert = false
    @State private var useLargeTitle = false
    @State private var isTransition = false
    @State private var banner = "𝐖𝐞𝐥𝐜𝐨𝐦𝐞"
    @State private var banner2 = "𝐭𝐨"
    @State private var banner3 = "𝐒𝐚𝐢𝐠𝐨𝐧 𝐂𝐨𝐧𝐧𝐞𝐜𝐭"
    
    var body: some View {
        NavigationStack {
                ZStack {
                    


                    VStack {
                        ZStack(alignment: .center) {
                            Image("app logo dark")
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(height: 250)
                            Image(systemName: "r.circle").resizable().frame(width: 20, height: 20).foregroundColor(.black)
                                .padding(.leading, 350)
                                .padding(.bottom, 90)
                        }
                        
                        VStack {
                            colored_Text(text: banner)
                                .padding(.horizontal)

                            colored_Text(text: banner2)
                                .padding(.horizontal)

                            colored_Text(text: banner3)
                                .padding(.horizontal)

                        }
                        
                        Spacer()
                        Button {
                            isTransition.toggle()
                        } label: {
                            HStack {
                                Text("Let's explore")
                                Spacer()
                                Image(systemName: "arrow.up.forward")
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal,25)
                            .frame(width: 340, height: 70)
                            .background(.black)
                            .clipShape(Capsule())
                            .padding(.bottom)
                        }.navigationDestination(
                            isPresented: $isTransition) {
                                Tab_View().navigationBarBackButtonHidden(true)
                            }

                        // Infor button
                        Button{
                            showingAlert = true;
                        }label :{
                            Image(systemName: "info.circle").resizable().frame(width: 25, height: 25).foregroundColor(.white)
                            
                        }
                        .alert( isPresented: $showingAlert) {

                            return Alert(title: Text("Saigon Connect"),
                            message: Text("\nAuthor: Quoc Huu Doan \n"  + "Sid: S3927776 \n" + "Version: 1.1.0 \n"
                            ))
                        }
                    }
                    .edgesIgnoringSafeArea(.top)
                }.background(Image("landmark81").resizable()
                 .aspectRatio(contentMode:.fill)
                 .edgesIgnoringSafeArea(.all))
                
            }
        
    }
}

struct welcomeScreen_Preview: PreviewProvider {
    static var previews: some View {
        welcomeScreen()
    }
}

struct colored_Text: View {
    var text: String
    @State private var bannerAnimation = false

    private func randomColor() -> Color {
        return Color(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1))
    }

    var body: some View {
        ZStack {
            Text(text)
                .font(.system(size: 50, weight: .bold))
                .opacity(0.3)

            HStack(spacing: 0) {
                ForEach(0..<text.count, id: \.self) { index in
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .foregroundColor(randomColor())
                        .opacity(1.0)
                        .font(.system(size: 50, weight: .bold))
                }
            }
            .mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: .init(colors: [Color.white.opacity(1), Color.white, Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .offset(x: bannerAnimation ? 300 : -150) // Adjust the offset to cover the entire text
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                    self.bannerAnimation.toggle()
                }
            }
        }
    }
}
