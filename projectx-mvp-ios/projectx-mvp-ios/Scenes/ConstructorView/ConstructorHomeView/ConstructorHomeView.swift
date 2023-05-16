//
//  ConstructorHomeView.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 15/5/23.
//

import SwiftUI

struct ConstructorHomeView: View {
    @State private var selectedIndex = 0
    @ObservedObject var viewModel: ConstructorHomeViewModel = ConstructorHomeViewModel()
    
    var body: some View {
        let sampleDate = Date()
        List {
            CardView(id: "1",
                     nombre: "Nombre del Evento",
                     fecha_inicio: sampleDate,
                     fecha_fin: sampleDate,
                     descripcion: "Descripción del evento",
                     latitud: 37.7749,
                     longitud: -122.4194,
                     estado: "Activo",
                     foto: "nombre_imagen")
            CardView(id: "1",
                     nombre: "Nombre del Evento",
                     fecha_inicio: sampleDate,
                     fecha_fin: sampleDate,
                     descripcion: "Descripción del evento",
                     latitud: 37.7749,
                     longitud: -122.4194,
                     estado: "Activo",
                     foto: "nombre_imagen")
        }
    }
}

struct ConstructorHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ConstructorHomeView()
    }
}
