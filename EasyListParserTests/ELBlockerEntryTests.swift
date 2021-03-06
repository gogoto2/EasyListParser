//
//  ELBlockerEntryTests.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/29/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import XCTest
@testable import EasyListParser

class ELBlockerEntryTests: XCTestCase {

    func testSerialization1() {
        // arrange
        let entry = ELBlockerEntry()
        let expected = "{\"trigger\":{},\"action\":{}}"
        
        // act
        let actual: String?
        do {
            actual = try entry.serialize()
        } catch _ {
            actual = nil
        }
        
        // assert
        XCTAssertEqual(expected, actual)
    }
    
    func testSerialization2() {
        // arrange
        let entry = ELBlockerEntry()
        entry.action.type = ELBlockerEntry.Action.Type.Block.rawValue
        entry.trigger.urlFilter = "some-url-filter"
        let expected = "{\"trigger\":{\"url-filter\":\"some-url-filter\"},\"action\":{\"type\":\"block\"}}"
        
        // act
        let actual: String?
        do {
            actual = try entry.serialize()
        } catch _ {
            actual = nil
        }
        
        // assert
        XCTAssertEqual(expected, actual)
    }
    
    func testSerialization3() {
        // arrange
        let entry = ELBlockerEntry()
        entry.action.type = ELBlockerEntry.Action.Type.CssDisplayNone.rawValue
        entry.action.selector = "some-css-selector"
        entry.trigger.urlFilter = "some-url-filter"
        let expected = "{\"trigger\":{\"url-filter\":\"some-url-filter\"},\"action\":{\"type\":\"css-display-none\",\"selector\":\"some-css-selector\"}}"
        
        // act
        let actual: String?
        do {
            actual = try entry.serialize()
        } catch _ {
            actual = nil
        }
        print(actual)
        
        // assert
        XCTAssertEqual(expected, actual)
    }
    
    func testSerialization4() {
        // arrange
        let entry = ELBlockerEntry()
        entry.action.type = ELBlockerEntry.Action.Type.CssDisplayNone.rawValue
        entry.action.selector = "some-css-selector"
        entry.trigger.urlFilter = "some-url-filter"
        let expected = "[{\"trigger\":{\"url-filter\":\"some-url-filter\"},\"action\":{\"type\":\"css-display-none\",\"selector\":\"some-css-selector\"}}]"
        
        // act
        let actual: String?
        do {
            actual = try [entry].serialize()
        } catch _ {
            actual = nil
        }
        print(actual)
        
        // assert
        XCTAssertEqual(expected, actual)
    }
    
}
