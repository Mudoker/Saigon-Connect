//
//  ContentView.swift
//  Saigon Connect
//
//  Created by Quoc Doan Huu on 18/07/2023.
//

import SwiftUI

struct welcomeScreen: View {
    
    @State private var showingAlert = false
    @State private var useLargeTitle = false
    @State private var showUnlock = false
    @State private var dragOffset:CGSize = .zero
    @State private var isTransition = false
    @State private var capsuleSize:CGSize = .init(width: 250, height: 60)
    @State private var sliderSize:CGSize = .init(width: 85, height: 60)
    @State private var sliderTextOpacity:Double = 0.25
    @State private var sliderAnimationOpacity:Double = 1
    @State private var sliderText = "Swipe to explore"
    @State private var banner = "𝐖𝐞𝐥𝐜𝐨𝐦𝐞"
    @State private var banner2 = "to"
    @State private var banner3 = "𝐕𝐢𝐞𝐭𝐧𝐚𝐦"
    @State private var sliderTextAnimation = false
    @State private var BannerAnimation = false
    @State private var BannerAnimation2 = false
    @State private var BannerAnimation3 = false
    private func handleDragChanged(_ value:DragGesture.Value) {
        if (value.translation.width <= capsuleSize.width - sliderSize.width && value.translation.width >= 0) {
            self.dragOffset = value.translation
            self.sliderTextOpacity = 0.25 - (dragOffset.width)/(capsuleSize.width)
            if self.sliderTextOpacity != 0.0 {
                self.sliderAnimationOpacity = 0.6 - (dragOffset.width)/(capsuleSize.width)
            }
            self.sliderAnimationOpacity = self.sliderTextOpacity
        }
        
    }
    private func randomColor() ->Color {
        return Color(red: CGFloat.random(in: 0...1),green: CGFloat.random(in: 0...1),blue: CGFloat.random(in: 0...1))
    }
    private func handleDragEnded() {
        if (dragOffset.width >= (capsuleSize.width/2 - sliderSize.width/2 + 60)) {
            isTransition = true
        }
        dragOffset = .zero
        self.sliderTextOpacity = 0.25
        self.sliderAnimationOpacity = 1
    }
    var body: some View {
        NavigationStack {
            if isTransition {
                SplashScreenView()
            } else {
                ZStack{
                    Image(systemName: "r.circle").resizable().frame(width: 15, height: 15).foregroundColor(.black).offset(x: 150, y: -320)
                    VStack {
                        
                        Image("App Logo").resizable().padding([.leading, .bottom, .trailing], 30.0).aspectRatio( contentMode: .fit).offset(x:-20,y:-40)
                        ZStack {
                            Text(banner).font(.system(size: 50, weight: .bold)).opacity(0.3).offset(x:-100, y:-130)
                            
                            HStack(spacing: 0) {
                                ForEach(0..<self.banner.count, id: \.self) { index in
                                    Text(String(self.banner[self.banner.index(self.banner.startIndex, offsetBy: index)]))
                                        .foregroundColor(randomColor())
                                        .opacity(1.0)
                                        .font(.system(size: 50, weight: .bold))
                                        .offset(x:-100,y:-130)
                                    
                                }
                            }.mask(
                                Rectangle()
                                    .fill (
                                        LinearGradient(gradient: .init(colors: [Color.white.opacity(1),Color.white,Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom)
                                    )
                                    .rotationEffect(.init(degrees: 50))
                                    .offset(x:-300,y: -180)
                                    .offset(x: self.BannerAnimation ? 500 : 0)
                            ).onAppear(perform:  {
                                withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                                    self.BannerAnimation.toggle()
                                }
                            })
                        }
                        ZStack {
                            Text(banner2).font(.system(size: 50, weight: .bold)).opacity(0.3).offset(x: -185, y:-130)
                            
                            HStack(spacing: 0) {
                                ForEach(0..<self.banner2.count, id: \.self) { index in
                                    Text(String(self.banner2[self.banner2.index(self.banner2.startIndex, offsetBy: index)]))
                                        .foregroundColor(randomColor())
                                        .opacity(1)
                                        .font(.system(size: 50, weight: .bold))
                                        .offset(x:-185, y:-130)
                                    
                                }
                            }.mask(
                                Rectangle()
                                    .fill (
                                        LinearGradient(gradient: .init(colors: [Color.white.opacity(1),Color.white,Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom)
                                    )
                                    .rotationEffect(.init(degrees: 0))
                                    .offset(x:-300,y: -120)
                                    .offset(x: self.BannerAnimation2 ? 500 : 0)
                            ).onAppear(perform:  {
                                withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                                    self.BannerAnimation2.toggle()
                                }
                            })
                        }
                        ZStack {
                            Text(banner3).font(.system(size: 60, weight: .bold)).opacity(0.3).offset(x: -87, y:-130)
                            
                            HStack(spacing: 0) {
                                ForEach(0..<self.banner3.count, id: \.self) { index in
                                    Text(String(self.banner3[self.banner3.index(self.banner3.startIndex, offsetBy: index)]))
                                        .foregroundColor(randomColor())
                                        .opacity(1)
                                        .font(.system(size: 60, weight: .bold))
                                        .offset(x:-87, y:-130)
                                    
                                }
                            }.mask(
                                Rectangle()
                                    .fill (
                                        LinearGradient(gradient: .init(colors: [Color.white.opacity(1),Color.white,Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom)
                                    )
                                    .rotationEffect(.init(degrees: 55))
                                    .offset(x:-300,y: -180)
                                    .offset(x: self.BannerAnimation3 ? 500 : 0)
                            ).onAppear(perform:  {
                                withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                                    self.BannerAnimation3.toggle()
                                }
                            })
                        }
                        
                        // Infor button
                        Button{
                            showingAlert = true;
                        }label :{
                            Image(systemName: "info.circle").resizable().frame(width: 25, height: 25).foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                        }
                        .offset(x:-20,y:190)
                        .alert( isPresented: $showingAlert) {
                    
                            return Alert(title: Text("Saigon Connect"),
                            message: Text("\nAuthor: Quoc Huu Doan \n"  + "Sid: S3927776 \n" + "Version: 1.1.0 \n"
                            ))
                        }
                        Spacer()
                    
                        ZStack {
                            Capsule()
                                .frame(width: capsuleSize.width, height: capsuleSize.height).padding(50)
                                .foregroundColor(.black).blendMode(.overlay).opacity(0.5)
                                .offset(x:-20)
                            ZStack {
                                Text(self.sliderText).foregroundColor(.white.opacity(self.sliderTextOpacity)).offset(x: capsuleSize.width - 230,y:-1)
                                    .fontWeight(.bold)
                                    
                                HStack(spacing: 0) {
                                    ForEach(0..<self.sliderText.count, id: \.self) { index in
                                        Text(String(self.sliderText[self.sliderText.index(self.sliderText.startIndex, offsetBy: index)])).offset(x: capsuleSize.width - 230, y:-1)
                                            .foregroundColor(randomColor())
                                            .opacity(sliderAnimationOpacity)
                                            .fontWeight(.bold)
                                        
                                    }
                                }.mask(
                                    Rectangle()
                                        .fill (
                                            LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5),Color.white,Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                                        )
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x:-250)
                                        .offset(x: self.sliderTextAnimation ? 500 : 0)
                                ).onAppear(perform:  {
                                    withAnimation(Animation.linear(duration: 3.5).repeatForever(autoreverses: false)) {
                                        self.sliderTextAnimation.toggle()
                                    }
                                })
                            }
                            
                            
                            ZStack {
                                Capsule()
                                    .frame(width:sliderSize.width, height: sliderSize.height)
                                    .opacity(1)
                                    .foregroundColor(.white)
                                    .offset(x:-20)
                                Image(systemName: "airplane").offset(x:-20)
                            }.offset(x:-(capsuleSize.width-sliderSize.width)/2 + dragOffset.width)
                                .gesture(DragGesture().onChanged { value in
                                    withAnimation(.spring(response:0.5, dampingFraction: 0.7)) {
                                        self.handleDragChanged(value)
                                    }
                                }.onEnded({_ in self.handleDragEnded()}))
                            
                        }
                    }
                    
                    
                }.background(Image("landmark81").resizable()
                    .aspectRatio(contentMode: .fill)).edgesIgnoringSafeArea(.all)
                }
            }
        }
        
}

struct welcomeScreen_Preview: PreviewProvider {
    static var previews: some View {
        welcomeScreen()
    }
}
