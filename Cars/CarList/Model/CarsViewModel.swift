//
//  CarsViewModel.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation

struct CarsViewModel {
    
    private let cars: CarModel
 
    var ListCars : [Car] {
        get {
            return cars.getCarSDetails ?? []
        }
    }
    
    init(carList: CarModel) {
        self.cars = carList
      }
    
}
