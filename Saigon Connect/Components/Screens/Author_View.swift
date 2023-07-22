//
//  Author_View.swift
//  Saigon Connect
//
//  Created by quoc on 22/07/2023.
//

import SwiftUI

struct Author_View: View {
    var body: some View {
        ZStack {
            GlassMorphicCard()
            VStack {
                Image("author").resizable().frame(width: 120, height: 120).clipShape(Circle())
                Text("Doan Huu Quoc").bold().font(.title)
                Text("Software Engineering -s3927776").italic()
                Text("React Native - iOS - Java").font(.footnote)


                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "phone")
                        Text("(+84) 83 8756 241")
                    }.padding(.bottom,5)
                        .padding(.top, 10)

                    HStack {
                        Image(systemName: "envelope")
                        Text("huuquoc7603@gmail.com")
                    }.padding(.bottom,5)

                    HStack {
                        Image(systemName: "envelope")
                        Text("s3927776@student.rmit.edu.au")
                    }.padding(.bottom,5)

                    HStack {
                        Image(systemName: "desktopcomputer")
                        Text("https://github.com/Mudoker")
                    }.padding(.bottom,5)

                }
                
            }
            .accentColor(.black)
        }.background(
            Image("background_light").resizable().aspectRatio(contentMode: .fill)
                .frame(minHeight: 1000)).ignoresSafeArea().edgesIgnoringSafeArea(.all)
    }
    @ViewBuilder
    func GlassMorphicCard() -> some View {
        ZStack {
            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in
            }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .opacity(0.5)
        }.frame(width: 290, height: 380)
    }
}

struct Author_View_Previews: PreviewProvider {
    static var previews: some View {
        Author_View()
    }
}
