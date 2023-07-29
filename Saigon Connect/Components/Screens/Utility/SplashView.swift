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
    Q.Doan, "Author Signature" unpublished, Jul. 2023.
    Q.Doan, "appIcon" unpublished, Jul. 2023.
*/

import SwiftUI
struct SplashView: View {
    // check to show the welcome screen or not
    @State private var isActive = false

    // size and opacity of the author signature
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        // Navigation stack to navigate to the welcome screen
        NavigationStack {
            // if the app is active, show the welcome screen
            if isActive {
                WelcomeScreen()
            } else {
                // otherwise, show the splash screen
                ZStack {
                    // background color
                    Color(.black)
                        .edgesIgnoringSafeArea(.all)

                    // VStack to store the author signature (image)
                    VStack {
                        VStack {
                            Image("Author Signature")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) { // animation to scale the image
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    }
                    .onAppear {
                        // navigate to the welcome screen after 2 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isActive = true
                        }
                    }
                    .navigationBarHidden(true) // hide the navigation bar
                }
            }
        }
    }

}

// preview of the splash screen
struct SplashView_Preview: PreviewProvider {
    static var previews: some View {
        SplashView()
    }

}
