//
//  ConstructorMainView.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 15/5/23.
//

import SwiftUI

struct ConstructorMainView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedIndex) {
                // Vista 1
                ConstructorHomeView()
                .badge(2)
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
                
                // Vista 2
                Text("Servicio no disponible en esta versión")
                    .tabItem {
                        Image(systemName: "message")
                        Text("Comunicación")
                    }
                    .tag(1)
                
                // Vista 3
                Text("Servicio no disponible en esta versión")
                    .tabItem {
                        Image(systemName: "map")
                        Text("Mapa")
                    }
                    .tag(2)
                
                // Vista 4
                Text("Contenido de la vista 4")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Perfil")
                    }
                    .tag(3)
            }
            
            // Botón central amarillo
            Button(action: {
                // Acción del botón central
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 50, height: 50)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .padding(12)
            }
            .offset(y: -24) // Ajusta la posición vertical del botón central
        }
    }
}


struct ConstructorMainView_Previews: PreviewProvider {
    static var previews: some View {
        ConstructorMainView()
    }
}
