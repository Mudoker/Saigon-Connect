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
    AppStuff. Side Menu in SwiftUI 2.0 Like A Professional | Select Menu Options (Dec. 9, 2020). Accessed Jul. 25, 2023. [Online Video]. Available: https://www.youtube.com/watch?v=5jPmILEQygY&t=627s
    
*/
import SwiftUI

struct SlideMenuView: View {

    // variables to store the index of the user and the state of the slide menu
    @AppStorage("userIndex") var userIndex = 0

    // variables to check for the state of the slide menu
    @Binding var isOpenSlideMenu: Bool

    // variables to check for dark mode
    @Binding var isDarkMode: Bool

    // Consider to remove this variable
    @State var isLogOut: Bool = false
    @State var isConfirmLogOut: Bool = false
    @Binding var isPlaceView: Bool
    @Binding var isEventView: Bool

    var body: some View {
            // Slide menu
            ZStack {
                // close menu button
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                isOpenSlideMenu.toggle()
                            }
                        }, label: {
                            Image (systemName: "arrow.right.to.line")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.horizontal)
                                .foregroundColor(isDarkMode ? .white : .black)
                        })
                    }
                    .padding(.top, 65)
                    Spacer()
                }

                // menu content
                VStack (alignment: .leading, spacing: 0) {
                    Text("Let's explore")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(isDarkMode ? .white : .black)
                        .padding(.top, 80)
                        .padding(.bottom, 30)

                    Divider()

                        // menu options for navigation
                        ScrollView (.vertical,showsIndicators: false) {
                            // place button
                            HStack {
                                Button {
                                    isPlaceView = true
                                    isEventView = false
                                } label: {
                                    Image(systemName: "house.circle")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                    Text("Dashboard")
                                        .foregroundColor(isDarkMode ? .white : .black)

                                    Spacer()
                                    
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .padding(.top)
                                Spacer()
                            }

                            Divider()

                            // event button
                            HStack {
                                Button {
                                    isPlaceView = false
                                    isEventView = true
                                } label: {
                                    Image(systemName: "figure.play")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                    Text("Events")
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    
                                     Spacer()
                                    
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .padding(.top)
                                Spacer()
                            }

                            Divider()

                            // dark mode button
                            HStack {
                                Image(systemName: "moon.circle")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(isDarkMode ? .white : .black)

                                Text("DarkMode")
                                    .foregroundColor(isDarkMode ? .white : .black)

                                // switch to change the state of the dark mode (with animation)
                                Button {
                                    isDarkMode.toggle()
                                } label: {
                                    ZStack {
                                        Capsule()
                                            .frame(width: 90,height: 40)
                                            .foregroundColor(isDarkMode ? Color.green : Color.gray)

                                        Circle()
                                            .frame(width: 45, height: 45)
                                            .foregroundColor(.white)
                                            .offset(x: isDarkMode ?  25 : -25)
                                            .shadow(radius: 10)
                                    }

                                }
                                .padding()
                                Spacer()
                            }

                            Divider()
                        }
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background( isDarkMode ? Image("background_dark")  : Image("background_light"))
            .ignoresSafeArea(.container, edges: .vertical)
            
        
    }

    // function to create a button
    // Consider to remove this function
    func creatButton (title: String, image: String) -> some View
    {
        Button{
        }label :{
            HStack {
                Image(systemName: image)
                    .resizable()
                    .foregroundColor(isDarkMode ? .white : .black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                Text(title).font(.body).foregroundColor(isDarkMode ? .white : .black)

            }
            .padding(.top)
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// consider to remove this extension
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

// preview
struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView(isOpenSlideMenu: .constant(true), isDarkMode: .constant(false), isPlaceView: .constant(false), isEventView: .constant(false))
    }
}

