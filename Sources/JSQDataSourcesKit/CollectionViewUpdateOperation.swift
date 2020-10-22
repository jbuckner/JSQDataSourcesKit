//
//  File.swift
//  
//
//  Created by Jason Buckner on 10/21/20.
//

import Foundation
import AsynchronousOperation
import UIKit

class CollectionViewUpdateOperation: AsynchronousOperation {
  init(
    collectionView: UICollectionView,
    changeGroup: ChangeGroup
  ) {
    self.collectionView = collectionView
    self.changeGroup = changeGroup
  }

  private weak var collectionView: UICollectionView?
  private let changeGroup: ChangeGroup

  override func main() {
    super.main()

    DispatchQueue.main.async {
      self.collectionView?.performBatchUpdates({ [weak self] in
        while let objectChange = self?.changeGroup.objectChanges.safeDequeue() {
          objectChange()
        }

        // apply section changes
        while let sectionChange = self?.changeGroup.sectionChanges.safeDequeue() {
          sectionChange()
        }

      }, completion: { [weak self] _ in
        self?.finish()
      })
    }
  }
}
