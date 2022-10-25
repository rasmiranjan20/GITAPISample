//
//  NetworkProtocol.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

protocol ParserProtocol {
    func parseData(_ data: Data) -> Result<Any, Error>
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

final class DefaultSession : NetworkSessionProtocol {
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
    func apiRequest(_ configuration: WebserviceConfigureble, session: NetworkSessionProtocol, parser:ParserProtocol) async throws -> Any
}

extension NetworkProtocol {
    func configureURL(_ configuration: WebserviceConfigureble, session: NetworkSessionProtocol = DefaultSession()) async throws -> Result<Data, NetworkErrors> {
        guard let request = configuration.request else {
            throw NetworkErrors.urlError
        }
        return await session.request(request)
    }
}
