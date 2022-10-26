//
//  Repository.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

@objc public class Repository : NSObject {
    var repoid          : Int?
    var reponame        : String?
    var repoDescription : String?
    var language        : String?
    var isPrivate       : Bool?
}

extension Repository {
    public override var description: String {
        return "repoid = \(String(describing:repoid)), language = \(String(describing:language)), reponame = \(String(describing:reponame)), isPrivate = \(String(describing: isPrivate))\n"
    }
}
