//
//  GoogleBookSearchTests.swift
//  GoogleBookSearchTests
//
//  Created by Brendon Crowe on 1/12/23.
//

import XCTest

@testable import GoogleBookSearch

final class GoogleBookSearchTests: XCTestCase {
    
    let filename = "Book"
    let ext = "json"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGettingData() {
        // act
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        // assert
        XCTAssertNotNil(data)
        
    }

    func getData() -> Data {
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        return data
    }
    
    func testJSONDecoding() {
        // arrange
        let data = getData()
        // act
        let books = Books.getBooks(from: data)
        
        XCTAssertGreaterThan(books.count, 0)
        
    }
    
    
}
