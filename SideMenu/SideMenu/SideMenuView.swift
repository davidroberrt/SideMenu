//
//  ContentView.swift
//  SideMenu
//
//  Created by David Robert on 07/03/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isMenuOpen: Bool
    @Binding var selectedView: String// Tela inicial
    @State private var gradientColors: [Color] = [Color.purple, Color.indigo]
    @State private var timer: Timer?


    var body: some View {
        ZStack {
            Color.white.opacity(0.8).ignoresSafeArea(.all)
                .cornerRadius(isMenuOpen ? 20 : 0)
                .frame(
                    maxWidth: isMenuOpen ? UIScreen.main.bounds.width * 0.85 : UIScreen.main.bounds.width ,
                    maxHeight: isMenuOpen ? UIScreen.main.bounds.height * 0.66 : UIScreen.main.bounds.height
                )
                .offset(x: isMenuOpen ? 250 : 0)
                .scaleEffect(isMenuOpen ? 0.85 : 1)
                .ignoresSafeArea(.all)
                .animation(.spring, value: isMenuOpen)
            if isMenuOpen {
                Color.blue.opacity(0.3)
                    .ignoresSafeArea()
            }
            
            
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("SideMenu")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    Spacer()
                    MenuItem(icon: "house", title: "Home") {
                        withAnimation(.spring(duration: 1.0)){
                            selectedView = "HomeView"
                            isMenuOpen = false
                        }
                    }
                    
                    MenuItem(icon: "map", title: "Map") {
                        withAnimation(.spring(duration: 1.0)){
                            selectedView = "MapView"
                            isMenuOpen = false
                        }
                    }
                    
                    MenuItem(icon: "person.fill.questionmark", title: "Help") {
                        withAnimation(.spring(duration: 1.0)){
                            selectedView = "HelpView"
                            isMenuOpen = false
                        }
                    }
                    MenuItem(icon: "gearshape", title: "Settings") {
                        withAnimation(.spring(duration: 1.0)){
                            selectedView = "SettingsView"
                            isMenuOpen = false
                        }
                    }
                    Spacer()
                    MenuItem(icon: "arrow.left.circle", title: "Signout") {
                        // Adicione a lógica de logout aqui
                        isMenuOpen = false

                    }
                    Spacer()
                }
                .padding(.top, 50)
                .frame(width: 250)
                .background(Color.clear)
                .offset(x: isMenuOpen ? 0 : -300)
                .transition(.move(edge: .leading))
                .animation(.easeInOut(duration: 0.5), value: isMenuOpen)
                
                Spacer()
            }
        }
        .background(
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    .onAppear {
                        if isMenuOpen {
                            startGradientAnimation()
                        }
                    }
                    .onChange(of: isMenuOpen) {_, newValue in
                        if newValue {
                            startGradientAnimation()
                        } else {
                            stopGradientAnimation()
                        }
                    }
                )
    }
    private func startGradientAnimation() {
        // Inicia o timer para a animação do gradiente
        stopGradientAnimation()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 3)) {
                    gradientColors = [Color.purple, Color.indigo]
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 3)) {
                    gradientColors = [Color.indigo, Color.purple]
                }
            }
        }
    }
    
    
    private func stopGradientAnimation() {
        // Interrompe o timer quando o menu não está aberto
        timer?.invalidate()
        timer = nil
    }
}



struct MenuItem: View {
    var icon: String
    var title: String
    var action: () -> Void  // Adiciona uma ação de clique

    var body: some View {
        Button(action: action) {  // Usa a ação ao clicar
            HStack {
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
    }
}


struct SecondPageView: View {
    @State private var isMenuOpen = false
    @Binding var selectedView: String
    var body: some View {
        ZStack {
            SideMenuView(isMenuOpen: $isMenuOpen, selectedView: $selectedView)
            NavigationView {
                VStack {
                    Button(action: {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    }) {
                        Text("Abrir Menu")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .cornerRadius(isMenuOpen ? 20 : 0)
                .frame(
                    maxWidth: isMenuOpen ? UIScreen.main.bounds.width * 0.75 : UIScreen.main.bounds.width ,
                    maxHeight: isMenuOpen ? UIScreen.main.bounds.height * 0.75 : UIScreen.main.bounds.height
                )
                .offset(x: isMenuOpen ? 250 : 0)
                .scaleEffect(isMenuOpen ? 0.85 : 1)
                .onTapGesture {
                    withAnimation {
                        isMenuOpen = false
                    }
                }
                .ignoresSafeArea(.all)
                .animation(.spring, value: isMenuOpen)
                .navigationTitle("AquaSafe")

                .scaleEffect(isMenuOpen ? 0.85 : 1) // Diminui a escala da tela ao abrir o menu
                .animation(.spring(), value: isMenuOpen)
            }

            .frame(maxWidth: isMenuOpen ? UIScreen.main.bounds.width * 0.75 : UIScreen.main.bounds.width, maxHeight: isMenuOpen ? UIScreen.main.bounds.height * 0.75 : UIScreen.main.bounds.height)
            .cornerRadius(isMenuOpen ? 20 : 0)

            .offset(x: isMenuOpen ? 150 : 0) // Move a tela para o lado ao abrir o menu
            .scaleEffect(isMenuOpen ? 0.85 : 1) // Diminui a escala da tela ao abrir o menu
            .onTapGesture {
                withAnimation {
                    isMenuOpen = false
                }
            }

        }
    }
}
