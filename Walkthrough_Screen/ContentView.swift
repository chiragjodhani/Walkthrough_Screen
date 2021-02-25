//
//  ContentView.swift
//  Walkthrough_Screen
//
//  Created by Eryushion Techsol on 24/02/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        if currentPage > totalPages {
            HomeView()
        }else {
            WalkthroughScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeView: View {
    var body: some View {
        Text("Welcome To Home !!!")
            .font(.title)
            .fontWeight(.heavy)
    }
}

//MARK: Walkthrough Screen
struct WalkthroughScreen: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        // For Slide Animation
        ZStack {
            if currentPage == 1 {
                ScreenView(image: "Image1", title: "Step 1", detail: "", bgColor: Color("Color1"))
                    .transition(.scale)
            }
            if currentPage == 2 {
                ScreenView(image: "Image2", title: "Step 2", detail: "", bgColor: Color("Color2"))
                    .transition(.scale)
            }
            if currentPage == 3 {
                ScreenView(image: "Image3", title: "Step 3", detail: "", bgColor: Color("Color3"))
                    .transition(.scale)
            }
        }
        .overlay(
            Button(action: {
                withAnimation(.easeInOut) {
                    if currentPage <= totalPages {
                        currentPage += 1
                    }else {
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    // Circular Slider......
                    .overlay(
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                Circle()
                                    .trim(from: 0.0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                    .stroke(Color.white, lineWidth: 4)
                                    .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-10)
                    )
            })
            .padding(.bottom, 20)
            , alignment: .bottom
        )
    }
}

struct ScreenView: View {
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        VStack(spacing: 20.0){
            HStack {
                
                if currentPage == 1 {
                    Text("Hello Member!")
                        .font(.title)
                        .fontWeight(.semibold)
                        // Letter Spacing......
                        .kerning(1.4)
                }else {
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            Text("Lorem ipsum is dummy text used in laying out print, graphic or web designs.")
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            Spacer(minLength: 120)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}


var totalPages = 3
