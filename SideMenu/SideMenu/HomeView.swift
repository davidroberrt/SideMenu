//
//  ContentView.swift
//  SideMenu
//
//  Created by David Robert on 07/03/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isMenuOpen = false
    @State private var selectedView: String = ""
    
    var body: some View {
        ZStack {
            SideMenuView(isMenuOpen: $isMenuOpen, selectedView: $selectedView)
            
            mainContent

        }
    }
    
    private var mainContent: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack{
                HStack {
                    Button(action: {
                        withAnimation(.spring()) {
                            isMenuOpen.toggle()
                        }
                    }) {
                        Image(systemName: "text.justify.left")
                            .font(.headline)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .frame(
            maxWidth: isMenuOpen ? UIScreen.main.bounds.width * 0.75 : UIScreen.main.bounds.width,
            maxHeight: isMenuOpen ? UIScreen.main.bounds.height * 0.75 : UIScreen.main.bounds.height
        )
        .cornerRadius(20)

        .offset(x: isMenuOpen ? 250 : 0)
        .scaleEffect(isMenuOpen ? 0.85 : 1)
        .onTapGesture {
            withAnimation(.spring()) {
                isMenuOpen = false
            }
        }
        .padding()
        
    }
}
#Preview {
    HomeView()
}
