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

        let repos = items.map({
            let repo = Repository()
            repo.repoid    = $0["id"] as? Int ?? 0
            repo.language  = $0["language"] as? String ?? ""
            repo.reponame  = $0["name"] as? String ?? ""
            repo.isPrivate = $0["private"] as? Bool ?? false
            repo.repoDescription  = $0["description"] as? String ?? ""
            return repo
        })
        return .success(repos)
    }
}
