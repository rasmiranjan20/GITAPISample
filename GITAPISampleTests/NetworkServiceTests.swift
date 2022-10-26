//
//  NetworkServiceTests.swift
//  GITAPISampleTests
//
//  Created by Rasmiranjan Sahu on 10/26/22.
//

import XCTest
@testable import GITAPISample

final class NetworkServiceTests: XCTestCase {

    func testNetworkServiceWithValidData() async {
        let validData       = self.expectation(description: "validData")
        let platform    = "android"
        let companyName = "rakutentech"
        do {
        let api = String(format: GITHUBRepoSearch, platform, companyName)
        let url = URL(string: api)
        let urlPath = Bundle(for: self.classForCoder).url(forResource: "repo_available", withExtension: "")
        let data = try Data(contentsOf: urlPath!)
        let configure = WebserviceConfigure(url: url!, requestTypes: .GET)
        var mockNetwork = NetworkSessionMock()
            mockNetwork.mockResult = .success(data)
            let repos = try await NetworkService().apiRequest(configure,  session: mockNetwork, parser: GitHubParser())
            guard let repos = repos as? [Repository] else {
                return
            }
            XCTAssertTrue(repos.count > 0, "Repos data empty")
            if let repo = repos.first {
                XCTAssertTrue(repo.reponame.count > 0, "reponame data is not coming.")
                XCTAssertTrue(repo.repoDescription.count > 0, "repoDescription data is not coming.")
                XCTAssertTrue(repo.language.count > 0, "language data is not coming.")
            }
            validData.fulfill()
        } catch {
            validData.fulfill()
        }
        self.wait(for: [validData], timeout: 3)
    }
    
    func testNetworkServiceWithInvalidOrg() async {
        let invalidOrg      = self.expectation(description: "invalidOrg")
        let platform    = "android"
        let companyName = "rakutentech1"
        do {
        let api = String(format: GITHUBRepoSearch, platform, companyName)
        let url = URL(string: api)
        let urlPath = Bundle(for: self.classForCoder).url(forResource: "repo_error", withExtension: "")
        let data = try Data(contentsOf: urlPath!)
        let configure = WebserviceConfigure(url: url!, requestTypes: .GET)
        var mockNetwork = NetworkSessionMock()
            mockNetwork.mockResult = .success(data)
            let repos = try await NetworkService().apiRequest(configure,  session: mockNetwork, parser: GitHubParser())
            guard let repos = repos as? [Repository] else {
                return
            }
            XCTAssertTrue(repos.count > 0, "Repos data empty")
            if let repo = repos.first {
                XCTAssertTrue(repo.reponame.count > 0, "reponame data is not coming.")
                XCTAssertTrue(repo.repoDescription.count > 0, "repoDescription data is not coming.")
                XCTAssertTrue(repo.language.count > 0, "language data is not coming.")
            }
            invalidOrg.fulfill()
        } catch {
            invalidOrg.fulfill()
        }
        self.wait(for: [invalidOrg], timeout: 3)
    }

    func testNetworkServiceWithInvalidPlatform() async {
        let invalidPlatform = self.expectation(description: "invalidPlatform")
        let platform    = "android1"
        let companyName = "rakutentech"
        do {
        let api = String(format: GITHUBRepoSearch, platform, companyName)
        let url = URL(string: api)
        let urlPath = Bundle(for: self.classForCoder).url(forResource: "repo_empty", withExtension: "")
        let data = try Data(contentsOf: urlPath!)
        let configure = WebserviceConfigure(url: url!, requestTypes: .GET)
        var mockNetwork = NetworkSessionMock()
            mockNetwork.mockResult = .success(data)
            let repos = try await NetworkService().apiRequest(configure,  session: mockNetwork, parser: GitHubParser())
            guard let repos = repos as? [Repository] else {
                return
            }
            XCTAssertTrue(repos.count == 0, "Repos data empty")
            if let repo = repos.first {
                XCTAssertTrue(repo.reponame.count > 0, "reponame data is not coming.")
                XCTAssertTrue(repo.repoDescription.count > 0, "repoDescription data is not coming.")
                XCTAssertTrue(repo.language.count > 0, "language data is not coming.")
            }
            invalidPlatform.fulfill()
        } catch {
            invalidPlatform.fulfill()
        }
    self.wait(for: [invalidPlatform], timeout: 3)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
