//
//  ViewController.swift
//  myFileNavLight
//
//  Created by Елизавета on 25.05.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit
import QuickLook

class DocsController: UIViewController, DownloadObserver {
    
    var docs: [Document] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: DocsCell.reuseId, bundle: nil), forCellWithReuseIdentifier: DocsCell.reuseId)
    }
    
    func setNewItem(data: Document) {
        docs.append(data)
        collectionView.reloadData()
    }
}

// MARK: -  UICollectionViewDelegate, UICollectionViewDataSource

extension DocsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocsCell.reuseId, for: indexPath) as! DocsCell
        cell.label.text = docs[indexPath.item].docName
        
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(docs[indexPath.item].docSize))
        
        cell.sizeLabel.text = string
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.currentPreviewItemIndex = indexPath.item
        self.present(previewController, animated: true, completion: nil)
    }
    
}

// MARK: -  QLPreviewControllerDataSource

extension DocsController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return docs.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let previewItem = NSURL(fileURLWithPath: docs[index].docUrl.path)
        return previewItem as QLPreviewItem
    }
}
