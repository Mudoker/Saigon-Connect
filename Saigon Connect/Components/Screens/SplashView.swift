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
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        NavigationStack {
            if isActive {
                WelcomeScreen()
            }
            else {
                ZStack {
                    Color(.black).edgesIgnoringSafeArea(.all)
                    VStack {
                        VStack {
                            Image("Author Signature")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isActive = true
                        }
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }

}
struct SplashView_Preview: PreviewProvider {
    static var previews: some View {
        SplashView()
    }

}
