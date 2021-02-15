//
//  BonprixChallengeTests.swift
//  BonprixChallengeTests
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import XCTest
@testable import BonprixChallenge


class BonprixChallengeTests: XCTestCase {

    lazy var jsonData: Data = {
        let jsonPath = Bundle(for: type(of: self)).url(forResource: "test", withExtension: "json")
        let jsonData = try! Data(contentsOf: jsonPath!, options: .mappedIfSafe)
        return jsonData
    }()

    func testDecodingAssortments() throws {
        let assortments = try AssortmentService.shared.getAssortmentsFrom(data: jsonData)
        
        XCTAssertFalse(assortments.isEmpty)
        XCTAssertNotNil(assortments[1].image)
        XCTAssertTrue(assortments.count == 2)
        
        XCTAssertTrue(assortments[0].childrenList.isEmpty)
        XCTAssertFalse(assortments[1].childrenList.isEmpty)
    }
    
    func testGettingImageFromAssortment() {
        let expectation = XCTestExpectation()
        
        let assortments = try? AssortmentService.shared.getAssortmentsFrom(data: jsonData)
        
        AssortmentService.shared.getImageFrom(assortment: assortments![1]) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(UIImage(data: data))
                expectation.fulfill()
            case .failure(_):
                XCTFail("Getting ImageData Failed")
            }
        }
        wait(for: [expectation], timeout: 5, enforceOrder: false)
    }
    
}
