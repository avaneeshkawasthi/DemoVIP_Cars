//
//  Constants.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation

public enum URLConstant: String {
   // Production Base URL
   case apiBaseURL = "https://www.apphusetreach.no/application/119267"
    
    // Test Base URL
    case apiBaseURLTest = ""
}

protocol NetworkTaskProtocol {
    var sessionHelper: URLSessionHelper { get }
}
