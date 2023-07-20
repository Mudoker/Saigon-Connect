//
//  Detail_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//

import SwiftUI

struct Detail_View: View {
    @State private var animateGradient = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("dinhdoclap").resizable().aspectRatio(contentMode: .fit)
                //                    .padding(.all)
                
                Text("The Independence Palace")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Text("This mansion used to be the workplace of the President of the Republic of Vietnam before 30/04/1975")
                    .padding(.leading)
                    .padding(.top, 0.1)
                    .opacity(0.7)
                Text("Price: 15.000 VND - 65.000 VND")
                    .padding(.leading)
                    .padding(.top, 0.1)
                    .padding(.bottom)
                    .opacity(0.7)
            }
            .foregroundColor(.white)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red:0.75, green: 0.28, blue:0.28), Color(red: 0.28, green: 0.0, blue: 0.28)]), startPoint:animateGradient ? .bottomLeading : .topLeading, endPoint: animateGradient ? .topTrailing : .bottomTrailing)
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration:3.5).repeatForever(autoreverses:true)) {
                                animateGradient.toggle()
                            }
                    })
            VStack (alignment: .leading) {
               
                Text("About")
                    .font(.title)
                    .padding([.bottom, .trailing])
                Text("The Independence Palace, also known as Dinh Doc Lap, has always been one of the most aesthetically mesmerizing historical relics in Ho Chi Minh City, Vietnam. Its design blends the modern influences of the Western world with the solemnity of the Eastern countries. Everyday, this palace attracts hundreds of visitors, and it holds a special significance as a must-visit destination for foreign heads of state.")
            }
            .padding()
        }
    }
}

struct Detail_View_Previews: PreviewProvider {
    static var previews: some View {
        Detail_View()
    }
}
