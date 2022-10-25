//
//  Repository.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

@objc public class Repository : NSObject {
    var repoid          = 0
    var reponame        = ""
    var repoDescription = ""
    var language        = ""
    var isPrivate       = false
}

extension Repository {
    public override var description: String {
        return "repoid = \(repoid), language = \(language), reponame = \(reponame), isPrivate = \(isPrivate)\n"
    }
}
