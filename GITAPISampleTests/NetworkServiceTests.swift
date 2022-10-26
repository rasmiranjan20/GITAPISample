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
        let mockNetwork = NetworkSessionMock(.success(data))
            let repos = try await NetworkService().apiRequest(configure,  session: mockNetwork, parser: GitHubParser())
            XCTAssertTrue(repos.count > 0, "Repos data empty")
            if let repo = repos.first {
                XCTAssertNotNil(repo.reponame, "reponame data is not coming.")
                XCTAssertNotNil(repo.repoDescription, "repoDescription data is not coming.")
                XCTAssertNotNil(repo.language, "language data is not coming.")
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
        let mockNetwork = NetworkSessionMock(.success(data))
            let repos = try await NetworkService().apiRequest(configure,  session: mockNetwork, parser: GitHubParser())
            XCTAssertTrue(repos.count > 0, "Repos data empty")
            if let repo = repos.first {
                XCTAssertNotNil(repo.reponame, "reponame data is not coming.")
                XCTAssertNotNil(repo.repoDescription, "repoDescription data is not coming.")
                XCTAssertNotNil(repo.language, "language data is not coming.")
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
        let mockNetwork = NetworkSessionMock(.success(data))
            let repos = try await NetworkService().apiRequest(configure,  session: mockNetwork, parser: GitHubParser())
            XCTAssertTrue(repos.count == 0, "Repos data empty")
            if let repo = repos.first {
                XCTAssertNotNil(repo.reponame, "reponame data is not coming.")
                XCTAssertNotNil(repo.repoDescription, "repoDescription data is not coming.")
                XCTAssertNotNil(repo.language, "language data is not coming.")
            }
            invalidPlatform.fulfill()
        } catch {
            invalidPlatform.fulfill()
        }
    self.wait(for: [invalidPlatform], timeout: 3)
    }
    
    func testNetworkServiceWithValidDataGeneric() async {
        let validData       = self.expectation(description: "validData")
        var platform    = "android"
        var companyName = "rakutentech"
        do {
        let api = String(format: GITHUBRepoSearch, platform, companyName)
        let url = URL(string: api)
        let urlPath = Bundle(for: self.classForCoder).url(forResource: "repo_available", withExtension: "")
        let data = try Data(contentsOf: urlPath!)
        let configure = WebserviceConfigure(url: url!, requestTypes: .GET)
        let mockNetwork = NetworkSessionMock(.success(data))
            let repos : RepositoryMock = try await NetworkService().apiRequest(configure,  session: mockNetwork)
            XCTAssertNotNil(repos, "Repos is nil")
            validData.fulfill()
        } catch {
            validData.fulfill()
        }
        
        let invalidInput = self.expectation(description: "invalidInput")
        platform    = "android1"
        companyName = "rakutentech"
        do {
            let api = String(format: GITHUBRepoSearch, platform, companyName)
            let url = URL(string: api)
            let urlPath = Bundle(for: self.classForCoder).url(forResource: "repo_empty", withExtension: "")
            let data = try Data(contentsOf: urlPath!)
            let configure = WebserviceConfigure(url: url!, requestTypes: .GET)
            let mockNetwork = NetworkSessionMock(.success(data))
                let repos : RepositoryMock = try await NetworkService().apiRequest(configure,  session: mockNetwork)
                XCTAssertNotNil(repos, "Repos is nil")
            invalidInput.fulfill()
            } catch {
                invalidInput.fulfill()
        }
        
        self.wait(for: [validData, invalidInput], timeout: 10)
    }
    
    func testNetworkServiceWithError() async {
        let invalidinput = self.expectation(description: "invalidinput")
        let platform    = "android"
        let companyName = "rakutentech"
        do {
        let api = String(format: GITHUBRepoSearch, platform, companyName)
        let url = URL(string: api)
        let configure = WebserviceConfigure(url: url!, requestTypes: .GET)
        let mockNetwork = NetworkSessionMock(.failure(NetworkErrors.networkerror))
            let _ = try await NetworkService().apiRequest(configure,  session: mockNetwork, parser: GitHubParser())
        } catch {
            invalidinput.fulfill()
        }
    self.wait(for: [invalidinput], timeout: 3)
    }
    
    func testNetworkServicInValidHTTPType() async {
        let invalidhttps = self.expectation(description: "invalidhttps")
        let platform    = "android"
        let companyName = "rakutentech"
        do {
        let api = String(format: GITHUBRepoSearch, platform, companyName)
        let url = URL(string: api)
        let configure = WebserviceConfigure(url: url!, requestTypes: .POST)
            let _ = try await NetworkService().apiRequest(configure, parser: GitHubParser())
            XCTAssert(false, "Failed conditions should called")
        } catch {
            invalidhttps.fulfill()
        }
    self.wait(for: [invalidhttps], timeout: 30)
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
