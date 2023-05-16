//
//  ConstructionCardView.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 16/5/23.
//

import SwiftUI

struct CardView: View {
    let id: String
    let nombre: String
    let fecha_inicio: Date
    let fecha_fin: Date
    let descripcion: String
    let latitud: Double
    let longitud: Double
    let estado: String?
    let foto: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(nombre)
                .font(.title)
            
            Text(descripcion)
                .font(.body)
            
            HStack {
                Image(systemName: "calendar")
                Text(formattedDate(date: fecha_inicio))
                Text("-")
                Text(formattedDate(date: fecha_fin))
            }
            
            if let estado = estado {
                Text("Estado: \(estado)")
            }
            
            Text("Ubicación: \(latitud), \(longitud)")
            
            Image(foto)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
    
    private func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleDate = Date()
        let card = CardView(id: "1",
                            nombre: "Nombre del Evento",
                            fecha_inicio: sampleDate,
                            fecha_fin: sampleDate,
                            descripcion: "Descripción del evento",
                            latitud: 37.7749,
                            longitud: -122.4194,
                            estado: "Activo",
                            foto: "nombre_imagen")
        card.previewLayout(.device)
    }
}
