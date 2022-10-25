//
//  GitHubParser.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/25/22.
//

import Foundation

final class GitHubParser : ParserProtocol {
    func parseData(_ data: Data) -> Result<Any, Error> {
        do {
            let values = try serializeData(data)
            let result = parseRepo(values)
            switch result {
            case .success(let repo):
                return .success(repo)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(error)
        }
    }
}

extension GitHubParser {
    func parseRepo(_ values: Any) -> Result<[Repository], Error> {
        guard let values = values as? [String : Any] else {
            return .failure(NetworkErrors.parsingError)
        }
        
        if let errors = values["errors"] as? [[String : Any]], let message = errors.first?["message"] {
            return .failure(NSError(domain: "NotFoundError", code: 100, userInfo: ["UserInfo" : message]))
        }
        
        guard let items = values["items"] as? [[String : Any]] else {
            return .failure(NetworkErrors.parsingError)
        }
        
        var repos = [Repository]()
        items.forEach { item in
            let repo = Repository()
            repo.repoid    = item["id"] as? Int ?? 0
            repo.language  = item["language"] as? String ?? ""
            repo.reponame  = item["name"] as? String ?? ""
            repo.isPrivate = item["private"] as? Bool ?? false
            repo.repoDescription  = item["description"] as? String ?? ""
            repos.append(repo)
        }
        
        return .success(repos)
    }
}
