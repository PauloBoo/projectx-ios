//
//  ConstructorHomeViewModel.swift
//  projectx-mvp-ios
//
//  Created by paulo.vazquez.acosta on 15/5/23.
//

import SwiftUI

class ConstructorHomeViewModel: ObservableObject {
    
    enum ViewState {
        case normal
        case loading
        case success
        case noUser
        case errorServer
        case noNetworkError
    }
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    @Published var idConstructor: String = ""
    @Published var viewState: ViewState = .normal
    @Published var constructionsResponseData: ConstructorHomeModels.ConstructionsResponseData?

    func getConstructions() {
        
        viewState = .loading

        Task {
            do {
                let constructionsResponseData = try await apiManager.getConstructions(idConstructor: idConstructor)
                DispatchQueue.main.async {
                    
                    self.constructionsResponseData = constructionsResponseData
                    self.viewState = .success
                }
            } catch {
                DispatchQueue.main.async {
                    self.constructionsResponseData = nil
                    switch error {
                    case APIError.serverError:
                        self.viewState = .errorServer
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    case APIError.noNetwork:
                        self.viewState = .noNetworkError
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    case APIError.noData:
                        self.viewState = .noUser
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.viewState = .normal
                        }
                    default:
                        self.viewState = .normal
                    }
                }
            }
        }
    }
}
