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
    
    
    var docs: [Data] = []
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: DocsCell.reuseId, bundle: nil), forCellWithReuseIdentifier: DocsCell.reuseId)
    }
    
    func setNewItem(data: Data) {
        docs.append(data)
        print("\(docs.count) in docs")
    }
}

extension DocsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 116)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocsCell.reuseId, for: indexPath) as! DocsCell
        cell.label.text = "\(indexPath.item)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let data = NSData(contentsOf: docs[indexPath.item] as URL)
//        print(data)
//      //  var im: UIImage?
//        if data != nil {
//            let cell = collectionView.cellForItem(at: indexPath) as! DocsCell
//            cell.image.image = UIImage(data: data! as Data)
        //}
        
        
    }
    func downloadItem(url: URL) {
        
    }
    
    
}

extension DocsController: QLPreviewControllerDataSource {
func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    return docs.count
}

func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
    let previewItem = docs[index]
    return previewItem as QLPreviewItem
}
}
