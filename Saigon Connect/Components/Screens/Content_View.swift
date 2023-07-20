//
//  Content_View.swift
//  Saigon Connect
//
//  Created by quoc on 20/07/2023.
//

import SwiftUI

struct Content_View: View {
    @State private var isDetailView = false

    var body: some View {
            NavigationStack {
                ScrollView {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack { // Use LazyHStack instead of HStack
                            ForEach(0..<5) { item in
                                NavigationLink(destination: Detail_View()){
                                
                                
                                    Places_Card_View()
//                                        .background(GlassMorphicCard())
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Dashboard")
                    
                }
            }
            
        }
}

struct Content_View_Previews: PreviewProvider {
    static var previews: some View {
        Content_View()
    }
}

struct Places_Card_View: View {
    //Make the gradient moving
    @State private var animateGradient = false

    var body: some View {
        
        ZStack(alignment: .top) {
            GlassMorphicCard()
            
            VStack(alignment: .leading) {
                Image("dinhdoclap").resizable().aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    
                
                Text("Independence Palace")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                
                Text("This mansion used to be the workplace of the President of the Republic of Vietnam before 30/04/1975")
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .padding(.top, 0.1)
                    .opacity(0.7)
                Text("Price: 15.000 VND - 65.000 VND")
                    .padding(.leading)
                    .padding(.top, 0.1)
                    .padding(.bottom)
                    .opacity(0.7)
                Spacer()
            }
            .foregroundColor(.white)
            .cornerRadius(30)
            .frame(width: 300, height: 500)
        }
    }
    @ViewBuilder
    func GlassMorphicCard() -> some View {
        ZStack {
            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in
            }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }.frame(width: 300, height: 380).background(
            LinearGradient(gradient: Gradient(colors: [Color(red:0.67, green: 0.03, blue:0.42), Color(red: 0.38, green: 0.02, blue: 0.37)]), startPoint:animateGradient ? .bottomLeading : .topLeading, endPoint: animateGradient ? .topTrailing : .bottomTrailing)
                .cornerRadius(30)
                .opacity(0.66)
                .shadow(radius: 10)
                .onAppear {
                    withAnimation(
                        .easeInOut(duration:1).repeatForever(autoreverses:true)) {
                            animateGradient.toggle()
                        }
                })
    }
}

struct CustomBlurView: UIViewRepresentable{
    var effect: UIBlurEffect.Style
    var onChange: (UIVisualEffectView) -> ()
    
    func makeUIView(context: Context) ->  UIVisualEffectView{
        return  UIVisualEffectView(effect: UIBlurEffect (style: effect))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            onChange(uiView)
        }
    }
}
