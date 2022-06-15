//
//  CarsPresenter.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation


class CarsPresenter: CarInteractorToPresenterProtocol {
    
    var view : CarPresenterToViewProtocol?
    
    func updateCarsDetailsWithSuccess(response: CarModel) {
        let viewModel = CarsViewModel(carList: response)
        view?.displayCars(list: viewModel)
    }
    
    func updateCarsDetailsWithFailure(error: APIError) {
        view?.displayError(error: error)
    }
    
}
