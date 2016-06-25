//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://jessesquires.com/JSQDataSourcesKit
//
//
//  GitHub
//  https://github.com/jessesquires/JSQDataSourcesKit
//
//
//  License
//  Copyright © 2015 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import Foundation
import UIKit
import XCTest

import JSQDataSourcesKit


final class DataSourceTests: XCTestCase {

    func test_thatDataSource_implements_dataSourceProtocol() {
        // GIVEN: some sections
        let sectionA = Section(items: FakeViewModel(), FakeViewModel(), headerTitle: "Header")
        let sectionB = Section(items: FakeViewModel(), FakeViewModel(), footerTitle: "Footer")
        let sectionC = Section(items: FakeViewModel(), FakeViewModel(), FakeViewModel())

        // WHEN: we create a data source
        let dataSource = DataSource(sections: sectionA, sectionB, sectionC)

        // THEN: it returns the expected data from the protocol methods
        XCTAssertEqual(dataSource.numberOfSections(), 3)
        XCTAssertEqual(dataSource.numberOfItems(inSection: 0), 2)
        XCTAssertEqual(dataSource.numberOfItems(inSection: 1), 2)
        XCTAssertEqual(dataSource.numberOfItems(inSection: 2), 3)
        XCTAssertEqual(dataSource.numberOfItems(inSection: 3), 0)

        XCTAssertEqual(dataSource.items(inSection: 0)!, sectionA.items)
        XCTAssertEqual(dataSource.items(inSection: 1)!, sectionB.items)
        XCTAssertEqual(dataSource.items(inSection: 2)!, sectionC.items)
        XCTAssertNil(dataSource.items(inSection: 3))

        XCTAssertEqual(dataSource.item(atRow:0, inSection: 0), sectionA[0])
        XCTAssertEqual(dataSource.item(atRow: 1, inSection: 0), sectionA[1])
        XCTAssertNil(dataSource.item(atRow: 2, inSection: 0))

        XCTAssertEqual(dataSource.headerTitle(inSection: 0), sectionA.headerTitle)
        XCTAssertNil(dataSource.footerTitle(inSection: 0))

        XCTAssertNil(dataSource.headerTitle(inSection: 1))
        XCTAssertEqual(dataSource.footerTitle(inSection: 1), sectionB.footerTitle)

        XCTAssertNil(dataSource.headerTitle(inSection: 2))
        XCTAssertNil(dataSource.footerTitle(inSection: 2))

        XCTAssertNil(dataSource.headerTitle(inSection: 4))
        XCTAssertNil(dataSource.footerTitle(inSection: 4))
    }

    func test_thatFetchedResultsController_implements_dataSourceProtocol() {
        // TODO:
    }

    func test_thatDataSource_returnsExpectedData_fromIntSubscript() {
        // GIVEN: a data source
        let sectionA = Section(items: FakeViewModel(), FakeViewModel(), headerTitle: "Header")
        let sectionB = Section(items: FakeViewModel(), FakeViewModel(), footerTitle: "Footer")
        let sectionC = Section(items: FakeViewModel(), FakeViewModel(), FakeViewModel())
        let dataSource = DataSource(sections: sectionA, sectionB, sectionC)

        // WHEN: we ask for a section
        let s = dataSource[1]

        // THEN: we receive the exepected data
        XCTAssertEqual(s.items, sectionB.items)
        XCTAssertEqual(s.headerTitle, sectionB.headerTitle)
        XCTAssertEqual(s.footerTitle, sectionB.footerTitle)
    }

    func test_thatDataSource_setsExpectedData_atIntSubscript() {
        // GIVEN: a data source
        let sectionA = Section(items: FakeViewModel(), FakeViewModel(), headerTitle: "Header")
        let sectionB = Section(items: FakeViewModel(), FakeViewModel(), footerTitle: "Footer")
        var dataSource = DataSource(sections: sectionA, sectionB)

        // WHEN: we set a section at a specific index
        let index = 1
        let sectionC = Section(items: FakeViewModel(), FakeViewModel(), FakeViewModel())
        dataSource[index] = sectionC

        // THEN: the section is replaced
        XCTAssertEqual(dataSource[index].items, sectionC.items)
        XCTAssertEqual(dataSource[index].headerTitle, sectionC.headerTitle)
        XCTAssertEqual(dataSource[index].footerTitle, sectionC.footerTitle)
    }

    func test_thatDataSource_returnsExpectedData_fromIndexPathSubscript() {
        // GIVEN: a data source
        let model = FakeViewModel()
        let sectionA = Section(items: FakeViewModel(), FakeViewModel(), headerTitle: "Header")
        let sectionB = Section(items: FakeViewModel(), FakeViewModel(), footerTitle: "Footer")
        let sectionC = Section(items: FakeViewModel(), FakeViewModel(), model)
        let dataSource = DataSource(sections: sectionA, sectionB, sectionC)

        // WHEN: we ask for an item
        let ip = NSIndexPath(forItem: 2, inSection: 2)
        let item = dataSource[ip]

        // THEN: we receive the exepected data
        XCTAssertEqual(item, model)
    }

    func test_thatDataSource_setsExpectedData_atIndexPathSubscript() {
        // GIVEN: a data source
        let sectionA = Section(items: FakeViewModel(), FakeViewModel(), headerTitle: "Header")
        let sectionB = Section(items: FakeViewModel(), FakeViewModel(), footerTitle: "Footer")
        var dataSource = DataSource(sections: sectionA, sectionB)

        // WHEN: we set an item at a specific index path
        let ip = NSIndexPath(forItem: 1, inSection: 0)
        let item = FakeViewModel()
        dataSource[ip] = item

        // THEN: the item is replaced
        XCTAssertEqual(dataSource[ip], item)
    }
}
