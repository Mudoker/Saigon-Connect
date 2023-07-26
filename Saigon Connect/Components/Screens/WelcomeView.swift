//
//  ContentView.swift
//  Saigon Connect
//
//  Created by Quoc Doan Huu on 18/07/2023.
//

import SwiftUI
struct WelcomeScreen: View {
    @State private var showingAlert = false
    @State private var useLargeTitle = false
    @State private var isTransition = false
    @State private var banner = "𝐖𝐞𝐥𝐜𝐨𝐦𝐞 𝐭𝐨"
    @State private var banner2 = "𝐒𝐚𝐢𝐠𝐨𝐧 𝐂𝐨𝐧𝐧𝐞𝐜𝐭"
    @State private var banner3 = "Unveil the soul of Vietnam"
    @State private var backgroundImageName = "welcome_background"
    @State private var backgroundAnimation = true
    private let backgroundChangeInterval: TimeInterval = 3.0
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    VStack {
                        Image("rmit-logo-white")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .padding(.top, 50)
                        ZStack(alignment: .center) {
                            Image("app logo light")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(height: 250)
                        }
                        .frame(height: 150)
                    }
                    VStack (alignment: .leading) {
                        Spacer()
                        ColoredText(text: banner, size: 40)
                        .padding(.horizontal)
                        ColoredText(text: banner2, size: 50)
                        .padding(.horizontal)
                        ColoredText(text: banner3, size: 20)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 40)
                    Spacer()
                    Button {
                        isTransition.toggle()
                    }
                    label: {
                        HStack {
                            Text("Let's explore")
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal,25)
                        .frame(width: 340, height: 70)
                        .background(.white)
                        .clipShape(Capsule())
                        .padding(.bottom)
                    }
                    .navigationDestination(
                        isPresented: $isTransition) {
                        LoginView().navigationBarBackButtonHidden(true)
                    }
                    // Infor button
                    Button{
                        showingAlert = true;
                    }
                    label :{
                        Image(systemName: "info.circle").resizable().frame(width: 25, height: 25).foregroundColor(.white)
                    }
                    .alert( isPresented: $showingAlert) {
                        return Alert(
                            title: Text("Saigon Connect"),
                            message: (Text("""
                                Author: Quoc Huu Doan
                                Sid: S3927776
                                Major: Software Engineering
                                Version: 1.1.0
                            """))
                        )
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
            .background(
                Image(backgroundImageName)
                .resizable()
                .overlay(Color.black.opacity(0.3))
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .offset(x: backgroundAnimation ? 10 : -50)
                .animation(Animation.easeInOut(duration: 4.0).repeatForever(), value: backgroundAnimation))
            .onAppear {
                // Start the animation when the view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    backgroundAnimation.toggle()
                }
            }
        }
    }
}


struct WelcomeScreen_Preview: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}

struct ColoredText: View {
    var text: String
    var size: CGFloat = 50
    @State private var bannerAnimation = false
    @State private var textColor = Color.black

    private func randomColor() -> Color {
        return Color(
            red: CGFloat.random(in: 0.8...1),
            green: CGFloat.random(in: 0.8...1),
            blue: CGFloat.random(in: 0.6...1)
        )
    }

    var body: some View {
        ZStack {
            Text(text)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.white)
                .opacity(0.6)

            HStack(spacing: 0) {
                ForEach(0..<text.count, id: \.self) { index in
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .foregroundColor(textColor)
                        .opacity(1.0)
                        .font(.system(size: size, weight: .bold))
                }
            }
            .mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: .init(colors: [Color.white.opacity(1), Color.white, Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .offset(x: bannerAnimation ? 300 : -150)
            )
            .onAppear {
                startAnimation()
            }
        }
    }

    private func startAnimation() {
        textColor = randomColor()
        withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
            self.bannerAnimation.toggle()
        }
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
            textColor = randomColor()
        }
    }
}
