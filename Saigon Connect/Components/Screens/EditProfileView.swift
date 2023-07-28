import SwiftUI

struct EditProfileView: View {
    @Binding var isDarkMode: Bool
    @State var userCreds: [User] = User.allUsers
    @AppStorage("userIndex") var userIndex = 0
    @State var isConfirmEdit = false
    @State var userName = ""
    @State var bio = ""
    @State var skill = ""
    @State var spotify = ""
    @State var github = ""
    @State var facebook = ""

    @State var isAlert = false
    var body: some View {
        VStack {
            Text("Edit profile")
                .font(.largeTitle)
                .bold()
                .foregroundColor(isDarkMode ? .white : .black)
            Image(systemName: userCreds[userIndex].avatar)
                .resizable().frame(width: 120, height: 120)
                .foregroundColor(isDarkMode ? .white : .black)
            ScrollView{
                Text("About you")
                    .font(.title)
                    .foregroundColor(isDarkMode ? .white : .black)
                HStack {
                    Text("Username")
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)

                    Spacer()
                    TextField("", text: $userName, prompt: Text(userCreds[userIndex].username).foregroundColor( isDarkMode ? .white.opacity(0.5) : .black.opacity(0.5))).multilineTextAlignment(.trailing)
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.horizontal)
                .padding(.bottom)
                HStack {
                    Text("Bio")
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)

                    Spacer()
                    TextField("", text: $bio, prompt: Text(userCreds[userIndex].bio).foregroundColor( isDarkMode ? .white.opacity(0.5) : .black.opacity(0.5))).multilineTextAlignment(.trailing)
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.horizontal)
                .padding(.bottom)
                HStack {
                    Text("Skills")
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)

                    Spacer()
                    TextField("", text: $skill, prompt: Text(userCreds[userIndex].skill).foregroundColor( isDarkMode ? .white.opacity(0.5) : .black.opacity(0.5))).multilineTextAlignment(.trailing)
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                Text("Social")
                    .font(.title)
                    .foregroundColor(isDarkMode ? .white : .black)
                HStack {
                    Text("Spotify")
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)

                    Spacer()
                    TextField("", text: $spotify, prompt: Text(userCreds[userIndex].connections.spotify ?? "").foregroundColor( isDarkMode ? .white.opacity(0.5) : .black.opacity(0.5))).multilineTextAlignment(.trailing)
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.horizontal)
                .padding(.bottom)
                HStack {
                    Text("Github")
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)

                    Spacer()
                    TextField("", text: $github, prompt: Text(userCreds[userIndex].connections.github ?? "").foregroundColor( isDarkMode ? .white.opacity(0.5) : .black.opacity(0.5))).multilineTextAlignment(.trailing)
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.horizontal)
                .padding(.bottom)
                HStack {
                    Text("Facebook")
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)

                    Spacer()
                    TextField("", text: $facebook, prompt: Text(userCreds[userIndex].connections.facebook ?? "").foregroundColor( isDarkMode ? .white.opacity(0.5) : .black.opacity(0.5))).multilineTextAlignment(.trailing)
                        .font(.title2)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding(.horizontal)
                .padding(.bottom)
                Button {
                    isAlert = true
                }
                label: {
                    HStack {
                        Text("Update")
                        .bold()
                        .font(.title3)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal,25)
                    .frame(width: 340, height: 60)
                    .background(Color(red: 1.00, green: 0.30, blue: 0.00))
                    .clipShape(Capsule())
                    .padding(.top)
                    .padding(.horizontal)
                }
                .alert(isPresented: $isAlert) {
                    Alert(
                        title: Text("Confirmation"),
                        message: Text("Are you sure you want to update?"),
                        primaryButton: .destructive(Text("Sure")) {
                            isConfirmEdit = true
                            if userName != "" {
                                userCreds[userIndex].username = userName
                                saveUserCredsToFile(userCreds: userCreds)
                                User.allUsers = decodeUserFromJsonFile(jsonFileName: "user.json")
                            }
                            
                        },
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                .fullScreenCover(isPresented: $isConfirmEdit) {
                            ProfileView(isDarkMode: $isDarkMode)
                }
            }

            
        }.background( isDarkMode ? Image("background_dark") : Image("background_light"))
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(isDarkMode: .constant(true))
    }
}

