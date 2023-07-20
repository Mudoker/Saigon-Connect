////
////  glassView.swift
////  Saigon Connect
////
////  Created by quoc on 21/07/2023.
////
//
//import SwiftUI
//
//struct glassView: View {
//    @State private var animateGradient = false
//
//    var body: some View {
//        ZStack {
//            Image("landmark81").resizable().ignoresSafeArea()
//            GlassMorphicCard()
//                .background(LinearGradient(gradient: Gradient(colors: [Color(red:0.67, green: 0.03, blue:0.42), Color(red: 0.38, green: 0.02, blue: 0.37)]), startPoint:animateGradient ? .bottomLeading : .topLeading, endPoint: animateGradient ? .topTrailing : .bottomTrailing)
//                    .blur(radius: 10)
//                    .onAppear {
//                        withAnimation(
//                            .easeInOut(duration:2).repeatForever(autoreverses:true)) {
//                                animateGradient.toggle()
//                            }
//                    }.opacity(0.6))
//                .cornerRadius(25)
//            VStack(alignment: .leading) {
//                Image("dinhdoclap").resizable().aspectRatio(contentMode: .fit)
//                    .cornerRadius(30)
//                
//                Text("The Independence Palace")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.leading)
//                    .padding(.leading)
//                
//                Text("This mansion used to be the workplace of the President of the Republic of Vietnam before 30/04/1975")
//                    .multilineTextAlignment(.leading)
//                    .padding(.leading)
//                    .padding(.top, 0.1)
//                    .opacity(0.7)
//                Text("Price: 15.000 VND - 65.000 VND")
//                    .padding(.leading)
//                    .padding(.top, 0.1)
//                    .padding(.bottom)
//                    .opacity(0.7)
//            }
//            .foregroundColor(.white)
//            .cornerRadius(30)
//            .frame(width: 300, height: 500)
//            .shadow(radius: 10)
//            
//        }
//    }
//    
//    @ViewBuilder
//    func GlassMorphicCard() -> some View {
//        ZStack {
//            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in
//            }
//            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
//        }.frame(width: 300, height: 500)
//    }
//}
//
//struct glassView_Previews: PreviewProvider {
//    static var previews: some View {
//        glassView()
//    }
//}
//
//struct CustomBlurView: UIViewRepresentable{
//    var effect: UIBlurEffect.Style
//    var onChange: (UIVisualEffectView) -> ()
//    
//    func makeUIView(context: Context) ->  UIVisualEffectView{
//        return  UIVisualEffectView(effect: UIBlurEffect (style: effect))
//    }
//    
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//        DispatchQueue.main.async {
//            onChange(uiView)
//        }
//    }
//}
//
//extension UIVisualEffectView {
//    var backDrop: UIView? {
//        return subView(forClass: NSClassFromString("_UIVisualEffectBackDropView"))
//    }
//}
//
//extension UIView {
//    func subView (forClass: AnyClass?) -> UIView? {
//        return subviews.first {
//            view in type (of: view) == forClass
//        }
//    }
//}
