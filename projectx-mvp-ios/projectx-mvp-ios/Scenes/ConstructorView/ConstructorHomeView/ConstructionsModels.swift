//
//  ConstructorHomeModels.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 15/5/23.
//

import Foundation

struct ConstructorHomeModels {
    
    struct ConstructionsResponseData: Codable, Equatable {
        let constructions: [Constructions]
    }
    
    struct Constructions: Codable, Equatable {
        let id: String
        let nombre: String
        let fecha_inicio: Date
        let fecha_fin: Date
        let descripcion: String
        let latitud: Double
        let longitud: Double
        let estado: String?
        let foto: String
    }
}
