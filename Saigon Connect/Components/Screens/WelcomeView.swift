/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 1
  Author: Doan Huu Quoc
  ID: 3927776
  Created  date: 18/07/2023
  Last modified: 26/07/2023
  Acknowledgement:
    Kavsoft. SwiftUI Animated Text Shimmer Effect - Custom Animations - SwiftUI Tutorials (Dec. 30, 2020). Accessed Jul. 18, 2023. [Online Video]. Available: https://www.youtube.com/watch?v=KYokxl1inRs&t=116s
    Q.Doan, "app logo light" unpublished, Jul. 2023.
    T.Huynh. "Week 3 - Intro to SwiftUI, Xcode & Layouts (I'm Rich App)" rmit.instructure.com.https://rmit.instructure.com/courses/121597/pages/w3-whats-happening-this-week?module_item_id=5219563
         (accessed Jul. 20, 2023).
*/

import SwiftUI

struct WelcomeScreen: View {
    // check to show author information or not
    @State private var showingAlert = false

    // check to use large title or not
    @State private var useLargeTitle = false

    // check for transition
    @State private var isTransition = false

    // variables to store the banner and background image
    @State private var banner = "𝐖𝐞𝐥𝐜𝐨𝐦𝐞 𝐭𝐨"
    @State private var banner2 = "𝐒𝐚𝐢𝐠𝐨𝐧 𝐂𝐨𝐧𝐧𝐞𝐜𝐭"
    @State private var banner3 = "Unveil the soul of Vietnam"
    @State private var backgroundImageName = "welcome_background"

    // variables to store the background animation
    @State private var backgroundAnimation = true

    var body: some View {
        // Navigation stack to navigate to the login screen
        NavigationStack {
            // ZStack to store the background image, logo, and banner
            ZStack {
                // VStack to store the logo and banner
                VStack {
                    Spacer()

                    // VStack to store the logo
                    VStack {
                        Image("rmit-logo-white")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .padding(.top, 50)

                        // ZStack to store the app logo
                        ZStack(alignment: .center) {
                            Image("app logo light")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 250)
                        }
                        .frame(height: 150)
                    }

                    // VStack to store the banner with animation
                    VStack(alignment: .leading) {
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

                    // Button to navigate to the login screen
                    Button {
                        isTransition.toggle()
                    } label: {
                        HStack {
                            Text("Let's explore")
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.forward")
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 25)
                        .frame(width: 340, height: 70)
                        .background(.white)
                        .clipShape(Capsule())
                        .padding(.bottom)
                    }
                    .navigationDestination(
                        isPresented: $isTransition
                    ) {
                        PlaceView()
                            .navigationBarBackButtonHidden(true)
                    }

                    // Button to show the author information
                    Button {
                        showingAlert = true
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                    .alert(isPresented: $showingAlert) {
                        return Alert(
                            title: Text("Saigon Connect"),
                            message: (Text(
                                """
                                    Author: Huu Quoc Doan
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
                    .animation(
                        Animation.easeInOut(duration: 4.0).repeatForever(),
                        value: backgroundAnimation
                    )
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    backgroundAnimation.toggle()
                }
            }
        }
    }
}

// Text shimmer animation
struct ColoredText: View {
    // variables to store the text and size
    var text: String
    var size: CGFloat = 50

    // variables to store the animation
    @State private var bannerAnimation = false

    // variable to store the text color
    @State private var textColor = Color.black

    // function to generate random color
    private func randomColor() -> Color {
        return Color(
            red: CGFloat.random(in: 0.8...1),
            green: CGFloat.random(in: 0.8...1),
            blue: CGFloat.random(in: 0.6...1)
        )
    }

    var body: some View {
        // ZStack to show shimmer animation
        ZStack {
            // Text to show the banner
            Text(text)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.white)
                .opacity(0.6)

            // Shimmering effect
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
                        LinearGradient(
                            gradient: .init(colors: [
                                Color.white.opacity(1), Color.white, Color.white.opacity(1),
                            ]
                            ), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .offset(x: bannerAnimation ? 300 : -150)
            )
            .onAppear {
                startAnimation()
            }
        }
    }

    // function to start the animation
    private func startAnimation() {
        // stop the newly created color
        textColor = randomColor()

        // shimmer animation
        withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
            self.bannerAnimation.toggle()
        }

        // change the text color every 4 seconds
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
            textColor = randomColor()
        }
    }
}

// Preview
struct WelcomeScreen_Preview: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
