//
//  ViewController.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import UIKit

enum Identifiers : String {
  case customCellIdentifier = "CarsTBCell"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var carsListTableView : UITableView!
    
    var interactor: CarViewToInteractorProtocol?
    var carsList : [Car]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.carsListTableView.register(UINib(nibName: "CarsTBCell", bundle: nil), forCellReuseIdentifier: Identifiers.customCellIdentifier.rawValue)
        self.carsListTableView.tableFooterView = UIView()
    }


}


extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let customCell  = self.carsListTableView.dequeueReusableCell(withIdentifier: Identifiers.customCellIdentifier.rawValue)
        if let cell = customCell as? CarsTBCell {
            cell.configureData(data: self.carsList?[indexPath.row])
            return cell
        }
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ViewController : CarPresenterToViewProtocol {
    func displayCars(list: CarsViewModel) {
        
        self.carsList = list.ListCars
        self.carsListTableView.reloadData()
    }
    
    func displayError(error: APIError) {
        print(error)
       // self.hideLoading()
        self.showErrorAlert(error: error)
    }
    
    fileprivate func showErrorAlert(error: APIError) {
            var message = ""
            
            switch error {
            
            case .invalidRequest, .invalidResponse, .parsingError, .unknown:
                message = "Something went wrong while processing your request"
            case .noConnection:
                message = "No internet connection available, try after sometime"
            case .noData:
                message = "Invalid request sent, try after sometime"
            }
            
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    
}
