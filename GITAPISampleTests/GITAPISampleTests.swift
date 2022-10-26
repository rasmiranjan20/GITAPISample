//
//  GITAPISampleTests.swift
//  GITAPISampleTests
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import XCTest
@testable import GITAPISample

final class GITAPISampleTests: XCTestCase {
    
    func testGitHubServiceWithValidData() async {
            let validData   = self.expectation(description: "validData")
            let platform    = "android"
            let companyName = "rakutentech"
            do {
               let repos = try await GitHubService.getRepoList(platform: platform, companyName: companyName)
                XCTAssertTrue(repos.count > 0, "Repos data empty")
                if let repo = repos.first {
                    XCTAssertNotNil(repo.description, "description data is not coming.")
                    XCTAssertNotNil(repo.reponame, "reponame data is not coming.")
                    XCTAssertNotNil(repo.repoDescription, "repoDescription data is not coming.")
                    XCTAssertNotNil(repo.language, "language data is not coming.")
                }
                validData.fulfill()
            } catch {
                validData.fulfill()
            }
            self.wait(for: [validData], timeout: 40)
    }
    
    func testGitHubServiceWithInvalidOrg() async {
            let invalidOrg      = self.expectation(description: "invalidOrg")
            let platform    = "android"
            let companyName = "rakutentech1"
            do {
               let repos = try await GitHubService.getRepoList(platform: platform, companyName: companyName)
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
            self.wait(for: [invalidOrg], timeout: 40)
    }

    func testGitHubServiceWithInvalidPlatform() async {
            let invalidPlatform = self.expectation(description: "invalidPlatform")
            let platform    = "android1"
            let companyName = "rakutentech"
            do {
               let repos = try await GitHubService.getRepoList(platform: platform, companyName: companyName)
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
        self.wait(for: [invalidPlatform], timeout: 40)
    }
    
    func testGitHubServiceWithInvalidInput() async {
            let invalidInput = self.expectation(description: "invalidInput")
            let platform    = "android1"
            let companyName = "rakuten😁tech"
            do {
               let _ = try await GitHubService.getRepoList(platform: platform, companyName: companyName)
                
            } catch {
                invalidInput.fulfill()
            }
        self.wait(for: [invalidInput], timeout: 40)
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
