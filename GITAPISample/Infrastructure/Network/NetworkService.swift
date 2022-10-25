//
//  NetworkService.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

final class NetworkService : NetworkProtocol {
    
    func apiRequest(_ configuration: WebserviceConfigureble, session: NetworkSessionProtocol = DefaultSession(), parser: ParserProtocol) async throws -> Any {
        do {
           let response = try await configureURL(configuration, session: session)
            switch response {
            case .success(let data):
                let parse = parser.parseData(data)
                switch parse {
                case .success(let success):
                    return success
                case .failure(let failure):
                    throw failure
                }
            case .failure(let error):
                throw error
            }
        } catch {
            throw error
        }
    }
    
    func apiRequest<T: Decodable>(_ configuration: WebserviceConfigureble, session: NetworkSessionProtocol = DefaultSession()) async throws -> T {
        do {
           let response = try await configureURL(configuration, session: session)
            switch response {
            case .success(let data):
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw error
                }
            case .failure(let error):
                throw error
            }
        } catch {
            throw error
        }
    }
    
    
}
