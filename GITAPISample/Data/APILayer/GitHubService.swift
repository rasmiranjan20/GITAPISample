//
//  GitHubService.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

@objc public class GitHubService : NSObject {
    @objc public class func getRepoList(platform: String, companyName: String) async throws -> [Repository] {
        var api : String? = String(format: GITHUBRepoSearch, platform, companyName)
        api = api?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let api = api, let url = URL(string: api) else {
            throw NetworkErrors.urlError
        }
        let configure = WebserviceConfigure(url: url, requestTypes: .GET)
        do {
            let repo = try await NetworkService().apiRequest(configure, parser: GitHubParser())
            return repo
        } catch {
            throw error
        }
    }
}
