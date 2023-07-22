//
//  Detail_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//

import SwiftUI

struct Detail_View: View {
    @State private var animateGradient = false
    @Binding var isDetailView: Bool

    var place: Place = Place.allPlace[0]
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading) {
                    Image(place.image_url)
                        .resizable()
                        .aspectRatio(contentMode:.fit)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity) // Image will cover all the available space above it
                    Spacer()
                    //                    .padding(.all)
                    
                    Text(place.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    
                    Text(place.short_description)
                        .padding(.leading)
                        .padding(.top, 0.1)
                        .opacity(0.7)
                    Text(place.entrance_fee)
                        .padding(.leading)
                        .padding(.top, 0.1)
                        .padding(.bottom)
                        .opacity(0.7)
                }
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(.white)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(red:0.75, green: 0.28, blue:0.28), Color(red: 0.28, green: 0.0, blue: 0.28)]), startPoint:animateGradient ? .bottomLeading : .topLeading, endPoint: animateGradient ? .topTrailing : .bottomTrailing)
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration:3.5).repeatForever(autoreverses:true)) {
                                    animateGradient.toggle()
                                }
                        })
            .cornerRadius(30)
            }
            VStack (alignment: .leading) {
               
                Text("About")
                    .font(.title)
                    .padding([.bottom, .trailing])
                    .padding(.leading)
                Text(place.full_description)
                    .padding(.leading)
            }
        }.onDisappear {
            isDetailView = false
        }
    }
}

struct Detail_View_Previews: PreviewProvider {
    @State static var isDetailView = true // Provide a binding here

    static var previews: some View {
        Detail_View(isDetailView: $isDetailView)
    }
}
