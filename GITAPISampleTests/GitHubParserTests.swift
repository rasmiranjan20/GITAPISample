//
//  GitHubParserTests.swift
//  GITAPISampleTests
//
//  Created by Rasmiranjan Sahu on 10/27/22.
//

import XCTest
@testable import GITAPISample

final class GitHubParserTests: XCTestCase {

    func testParseRepoFailedCondition() {
        let values = "ABCD"
        let result = GitHubParser().parseRepo(values)
        switch result {
        case .success(_):
            XCTAssert(false, "It must be failed")
        case .failure(_): break
        }
        do {
            let _ = try GitHubParser().serializeData(Data(values.utf8))
            XCTAssert(false, "It should failed because of invalid data.")
        } catch {
            
        }
        let result1 = GitHubParser().parseData(Data(values.utf8))
        switch result1 {
        case .success(_):
            XCTAssert(false, "It must be failed")
        case .failure(_): break
        }
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
