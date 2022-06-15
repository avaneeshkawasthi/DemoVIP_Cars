//
//  CarsConfigurator.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation
import UIKit

@objc class getCarsConfigurator: NSObject {

    @objc public static let shared: getCarsConfigurator = { return getCarsConfigurator() }()

    @objc public func configure() -> ViewController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController

        let interactor = CarsInteractor()
        let presenter = CarsPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController

        interactor.getCarsList()

        return viewController
    }
}
