//
//  NetworkProtocol.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

protocol ParserProtocol {
    associatedtype T
    func parseData(_ data: Data) -> Result<T, Error>
}

extension ParserProtocol {
    func serializeData(_ data: Data) throws -> Any {
        do {
            let object = try JSONSerialization.jsonObject(with: data)
            return object
        } catch {
            throw error
        }
    }
}

protocol NetworkSessionProtocol {
    func request(_ request: URLRequest) async -> Result<Data, NetworkErrors>
}

struct DefaultSession : NetworkSessionProtocol {
    func request(_ request: URLRequest) async -> Result<Data, NetworkErrors> {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return .success(data)
        } catch {
            return .failure(.defaultError(error))
        }
    }
}


protocol NetworkProtocol {
    func apiRequest<T : Decodable>(_ configuration: WebserviceConfigureble, session: NetworkSessionProtocol) async throws -> T
    func apiRequest<P :ParserProtocol>(_ configuration: WebserviceConfigureble, session: NetworkSessionProtocol, parser:P) async throws -> P.T
}

extension NetworkProtocol {
    func configureURL(_ configuration: WebserviceConfigureble, session: NetworkSessionProtocol = DefaultSession()) async throws -> Result<Data, NetworkErrors> {
        return await session.request(configuration.request)
    }
}
