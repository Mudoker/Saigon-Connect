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
    @State var userCreds: [User] = User.allUsers
    @AppStorage("userIndex") var userIndex = 0
    @Binding var isOpenSlideMenu: Bool
    @Binding var isDarkMode: Bool
    @State var isLogOut: Bool = false
    @State var isConfirmLogOut: Bool = false
    @Binding var isProfileView: Bool

    var background_light = LinearGradient(
        gradient: Gradient(colors: [Color(red: 1, green: 0.90, blue: 0.95), Color(red: 0.43, green: 0.84, blue: 0.98)]),
                startPoint: .top,
                endPoint: .bottom
            )
    var background_dark = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.06, green: 0.13, blue: 0.15), Color(red: 0.13, green: 0.23, blue: 0.26), Color(red: 0.17, green: 0.33, blue: 0.39)]),
                startPoint: .top,
                endPoint: .bottom
            )
    var body: some View {
            ZStack {
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
                    .padding(.top, 50)
                    Spacer()
                }
                VStack (alignment: .leading, spacing: 0) {
                        HStack {
                            HStack (alignment: .center) {
                                Image(systemName: userCreds[userIndex].avatar)
                                    .resizable()
                                    .foregroundColor(isDarkMode ? .white : .black)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)

                                VStack {
                                    Text(userCreds[userIndex].username).font(.title2.bold())
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Text("@" + userCreds[userIndex].type).font(.callout)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }

                                

                            }
                            .padding(.top, 50)
                            Spacer()
                        }
                    
                    HStack {
                        VStack {
                            Text(String(userCreds[userIndex].following))
                                .font(.title)
                                .bold()
                                .foregroundColor(isDarkMode ? .white : .black)
                            Text("Following")
                                .font(.caption)
                                .foregroundColor(isDarkMode ? .gray : .black)
                                .opacity(0.5)

                        }
                        
                        VStack {
                            Text(String(userCreds[userIndex].followers))
                                .font(.title)
                                .bold()
                                .foregroundColor(isDarkMode ? .white : .black)
                            Text("Followers")
                                .font(.caption)
                                .foregroundColor(isDarkMode ? .gray : .black)
                                .opacity(0.5)

                        }.padding(.horizontal)
                        
                        VStack {
                            Text(String(userCreds[userIndex].likes))
                                .font(.title)
                                .bold()
                                .foregroundColor(isDarkMode ? .white : .black)
                            Text("Likes")
                                .font(.caption)
                                .foregroundColor(isDarkMode ? .gray : .black)
                                .opacity(0.5)

                        }
                    }
                    .padding(.vertical)

                        Divider()

                        ScrollView (.vertical,showsIndicators: false) {
                            HStack {
                                Button {
                                    isProfileView = false
                                } label: {
                                    Image(systemName: "house.circle")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                    Text("Dashboard")
                                        .foregroundColor(isDarkMode ? .white : .black)
                                        .padding(.trailing, 15)
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                }
                                .padding(.top)
                                Spacer()
                            }
                            Divider()
                            HStack {
                                Button {
                                    isProfileView = true
                                } label: {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                    Text("Profile")
                                        .foregroundColor(isDarkMode ? .white : .black)
                                        .padding(.trailing, 50)
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(isDarkMode ? .white : .black)

                                }
                                .padding(.top)
                                Spacer()
                            }
                            Divider()

                            HStack {
                                Image(systemName: "moon.circle")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(isDarkMode ? .white : .black)

                                Text("DarkMode")
                                    .foregroundColor(isDarkMode ? .white : .black)

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

                            Button {
                                isConfirmLogOut.toggle()
                            } label: {
                                ZStack {
                                    Text("Sign out")
                                        .foregroundColor(.red)
                                        .bold()
                                        .font(.title3)
                                }

                            }
                            .alert(isPresented: $isConfirmLogOut) {
                                Alert(
                                    title: Text("Confirmation"),
                                    message: Text("Are you sure you want to sign out?"),
                                    primaryButton: .destructive(Text("Sign out")) {
                                        isLogOut = true
                                    },
                                    secondaryButton: .cancel(Text("Cancel"))
                                )
                            }
                            .fullScreenCover(isPresented: $isLogOut) {
                                        LoginView()
                            }
                            
                        }
                       
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background( isDarkMode ? Image("background_dark")  : Image("background_light"))
        .ignoresSafeArea(.container, edges: .vertical)
            
        
    }

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

struct SlideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView(isOpenSlideMenu: .constant(true), isDarkMode: .constant(false), isProfileView: .constant(false))
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
