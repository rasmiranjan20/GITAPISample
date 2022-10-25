//
//  GitHubService.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

@objc public class GitHubService : NSObject {
    @objc public class func getRepoList(platform: String, companyName: String) async throws -> [Repository] {
        let api = String(format: GITHUBRepoSearch, platform, companyName)
        let url = URL(string: api)
        let configure = WebserviceConfigure(url: url!, requestTypes: .GET)
        do {
            let repo = try await NetworkService().apiRequest(configure, parser: GitHubParser())
            guard let repo = repo as? [Repository] else {
                throw NetworkErrors.parsingError
            }
            return repo
        } catch {
            throw error
        }
    }
}
