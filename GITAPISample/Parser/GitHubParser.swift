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
        print("values::\(values)")
        return .success([Repository()])
    }
}
