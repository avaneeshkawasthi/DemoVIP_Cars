//
//  CarsInteractor.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation

class CarsInteractor: CarViewToInteractorProtocol {
    
    var presenter: CarInteractorToPresenterProtocol?
    private lazy var getCarWorker: GetCarsAPIWorker = { GetCarsAPIWorker() }()

    func getCarsList() {
        self.getCarWorker.getCarList {  [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let detail):
                self.presenter?.updateCarsDetailsWithSuccess(response: detail)
            case .failure(let error):
                self.presenter?.updateCarsDetailsWithFailure(error: error)
            }
        }
    }
    
    func GetCarListFromDataBase() {
        
        
    }
}
