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
    P.Hudson. "How to open web links in Safari" HACKING WITH SWIFT. https://www.hackingwithswift.com/quick-start/swiftui/how-to-open-web-links-in-safari (accessed Jul. 25, 2023).
*/

import SwiftUI

struct ProfileView: View {
    @State var isEditProfile: Bool = false
    @Binding var isDarkMode: Bool
    @State var userCreds: [User] = User.allUsers
    @State var isOpenSlideMenu = false
    @State var isProfileView = true
    @State var isFavourite = true
    @State var isLink = false
    @AppStorage("userIndex") var userIndex = 0
    var body: some View {
        NavigationStack {
            ZStack {
                if isOpenSlideMenu {
                    SlideMenuView(isOpenSlideMenu: $isOpenSlideMenu, isDarkMode: $isDarkMode, isProfileView: $isProfileView)
                }
                if !isProfileView {
                    ContentView()
                } else {
                    VStack {
                        HStack() {
                            // navbar button
                            Button {
                                withAnimation(.spring()) {
                                    isOpenSlideMenu.toggle()
                                }
                            }
                            label: {
                                Image(systemName: "line.3.horizontal").resizable()
                                .frame(width: 40, height: 20)
                                .foregroundColor(isDarkMode ? .white : .black)
                            }
                            Text("Profile")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(isDarkMode ? .white : .black)//
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                        .frame(height: 80)
                        VStack {
                            Image(systemName: userCreds[userIndex].avatar)
                                .resizable().frame(width: 120, height: 120)
                                .foregroundColor(isDarkMode ? .white : .black)
                            
                            Text(userCreds[userIndex].username)
                                .font(.title)
                                .foregroundColor(isDarkMode ? .white : .black)
                            
                            Text(userCreds[userIndex].bio)
                                .foregroundColor(isDarkMode ? .white : .black)
                                .font(.title3)
                            Text(userCreds[userIndex].skill)
                                .foregroundColor(isDarkMode ? .white : .black)
                                .italic()
                            HStack (spacing: 30) {
                                Spacer()
                                VStack {
                                    Text(String(userCreds[userIndex].following))
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Text("Following")
                                        .font(.title3)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                        .opacity(0.5)
                                }
                                
                                VStack {
                                    Text(String(userCreds[userIndex].followers))
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Text("Followers")
                                        .font(.title3)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                        .opacity(0.5)

                                }
                                
                                VStack {
                                    Text(String(userCreds[userIndex].likes))
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Text("Likes")
                                        .font(.title3)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                        .opacity(0.5)

                                }
                                
                                Spacer()
                            }
                            .padding(.vertical, 5)
                            .padding(.trailing,35)
                            
//                            if userIndex != 1 {
//                                NavigationLink(
//                                    destination: EditProfileView(isDarkMode: $isDarkMode))
//                                {
//                                    Text("Edit profile")
//                                            .foregroundColor(isDarkMode ? .white : .black)
//                                            .padding()
//                                            .background(isDarkMode ? .purple : Color.white)
//                                            .cornerRadius(20)
//                                }
//                            }
                            
                            ScrollView {
                                if let spotify = userCreds[userIndex].connections.spotify, let _ = URL(string: spotify) {
                                    Link(destination: URL(string: spotify)!) {
                                        HStack {
                                            Image(systemName: "line.3.horizontal.decrease.circle")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.green)
                                                .padding()
                                            Text("Spotify")
                                                .font(.title)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            Spacer()
                                            Image(systemName: "arrow.up.forward.app")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                        .padding(.horizontal)
                                        .background(isDarkMode ? .purple : Color.white)
                                            .cornerRadius(20)
                                    }
                                }
                                
                                if let github = userCreds[userIndex].connections.github, let _ = URL(string: github) {
                                    Link(destination: URL(string: github)!) {
                                        HStack {
                                            Image(systemName: "poweroutlet.type.f.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                                .padding()
                                            Text("Spotify")
                                                .font(.title)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            Spacer()
                                            Image(systemName: "arrow.up.forward.app")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                        .padding(.horizontal)
                                        .background(isDarkMode ? .purple : Color.white)
                                            .cornerRadius(20)
                                    }
                                }
                                
                                if let facebook = userCreds[userIndex].connections.facebook, let _ = URL(string: facebook) {
                                    Link(destination: URL(string: facebook)!) {
                                        HStack {
                                            Image(systemName: "f.cursive.circle.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(Color(red: 0.26, green: 0.40, blue: 0.70))
                                                .padding()
                                            Text("Facebook")
                                                .font(.title)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            Spacer()
                                            Image(systemName: "arrow.up.forward.app")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                        .padding(.horizontal)
                                        .background(isDarkMode ? .purple : Color.white)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            .padding(.top, 25)
                        }
                        Spacer()
                    }.blur(radius: isOpenSlideMenu ? 50 : 0)
                        .offset(x: isOpenSlideMenu ? 300 : 0)
                        .scaleEffect(isOpenSlideMenu ? 0.8 : 1)
                }
                
                
        }.background( isDarkMode ? Image("background_dark") : Image("background_light"))
        }
        
    }
}

struct Profile_View_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isDarkMode: .constant(true))
    }
}
