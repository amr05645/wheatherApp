//
//  HomeViewModel.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var wheather: WheatherModel?
    @Published private(set) var errorMessage: String = ""
    
    private let wheatherService = WheatherService()
    
    
    //MARK: - Api Calling
    
    func fetchWheatherData(_ cityName: String) async {
        do {
            let apiConstructor = ApiConstructor(endPoint: .wheather)
            let wheatherApiResponse: WheatherModel = try await wheatherService.fetchData(api: apiConstructor, cityName)
            wheather = wheatherApiResponse
            print("result is:", wheather)
            
        } catch {
            errorMessage = "Error: \(error)"
        }
    }
}
