//
//  NetworkSessionMock.swift
//  GITAPISampleTests
//
//  Created by Rasmiranjan Sahu on 10/26/22.
//
@testable import GITAPISample
import Foundation

struct NetworkSessionMock : NetworkSessionProtocol {
    var mockResult : Result<Data, GITAPISample.NetworkErrors>!
    init(_ mockResult: Result<Data, GITAPISample.NetworkErrors>!) {
        self.mockResult = mockResult
    }
    func request(_ request: URLRequest) async -> Result<Data, GITAPISample.NetworkErrors> {
        return mockResult
    }
}
