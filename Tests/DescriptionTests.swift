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


final class DescriptionTests: XCTestCase {

    func test_CollectionViewDataSource_Descriptions() {
        print("\(#function)\n")
        let fakeCollectionView = FakeCollectionView(frame: CGRect.zero, collectionViewLayout: FakeFlowLayout())

        let section = Section(items: FakeViewModel(), FakeViewModel())
        print(section, "\n")

        let cellFactory = ViewFactory(reuseIdentifier: "cellId") { (cell, model: FakeViewModel?, type, view, indexPath) -> FakeCollectionCell in
            return cell
        }
        print(cellFactory, "\n")

        let supplementaryViewFactory = CollectionSupplementaryViewFactory(reuseIdentifier: "supplementaryId", kind: "kind") {
            (view, model: FakeViewModel?, kind, collectionView, indexPath) -> FakeCollectionSupplementaryView in
            return view
        }
        print(supplementaryViewFactory, "\n")

        let titledSupplementaryViewFactory = TitledCollectionReusableViewFactory(dataConfigurator: {
            (view, item: FakeViewModel?, kind, cv, indexPath) -> TitledCollectionReusableView in
            return view
        }) { (view) -> Void in
        }
        print(titledSupplementaryViewFactory, "\n")

        let dataSourceProvider = CollectionViewDataSourceProvider(
            sections: [section],
            cellFactory: cellFactory,
            supplementaryViewFactory: supplementaryViewFactory,
            collectionView: fakeCollectionView)

        print(dataSourceProvider, "\n")
    }

    func test_TableViewDataSource_Descriptions() {
        print("\(#function)\n")

        let section = Section(items: FakeViewModel(), FakeViewModel())
        print(section, "\n")

        let cellFactory = ViewFactory(reuseIdentifier: "cellId") { (cell, model: FakeViewModel?, type, view, indexPath) -> FakeTableCell in
            return cell
        }
        print(cellFactory, "\n")

        let dataSourceProvider = DataSourceProvider(
            sections: [section],
            cellFactory: cellFactory,
            supplementaryFactory: cellFactory)
        
        print(dataSourceProvider, "\n")
    }
}
