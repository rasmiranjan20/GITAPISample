//
//  NetworkErrors.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

enum NetworkErrors : Error {
    case urlError
    case networkerror
    case responseerror
    case parsingError
    case defaultError(Error)
}
