//
//  APIManager+Constructions.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 16/5/23.
//

extension APIManager {
    
    func getConstructions(idConstructor: String) async throws -> ConstructorHomeModels.ConstructionsResponseData {
        return try await fetch(.getObrasbyConstructor(id: idConstructor),
                               responseType: ConstructorHomeModels.ConstructionsResponseData.self)
    }

}
