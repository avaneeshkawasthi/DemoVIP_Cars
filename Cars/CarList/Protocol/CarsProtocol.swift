//
//  CarsProtocol.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation



protocol CarViewToInteractorProtocol: AnyObject {
    
    func getCarsList()
}

protocol CarInteractorToPresenterProtocol: AnyObject {
    
    func updateCarsDetailsWithSuccess(response : CarModel)
    func updateCarsDetailsWithFailure(error: APIError)
    
}


protocol CarPresenterToViewProtocol: AnyObject {
    
    func displayCars(list : CarsViewModel)
    func displayError(error: APIError)
    
}






