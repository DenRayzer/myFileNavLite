//
//  DownloadController.swift
//  myFileNavLight
//
//  Created by Елизавета on 25.05.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class DownloadController: UIViewController {
    var manager: EventManager? = nil
    let ur = URL.init(string: "https://wolverine.raywenderlich.com/books/con/image-from-rawpixel-id-466780-jpeg.jpg")
    var links : [URL?] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: DownloadCell.reuseId, bundle: nil), forCellWithReuseIdentifier: DownloadCell.reuseId)
        links.append(ur)
    }
    
    
}

extension DownloadController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DownloadCell.reuseId, for: indexPath) as! DownloadCell
        cell.linkLabel.text = "\(indexPath.item)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = links[indexPath.item] else { return  }
        do {
            let dg = DispatchGroup()
            dg.enter()
            let data = try Data(contentsOf: url)
          //  let data =  try Data.init(contentsOf: url)
            //let content = try String(contentsOf: url)
          //  print(content)
            dg.leave()
            
            dg.notify(queue: .main) {
                self.manager?.notifyDownloadFinished(data: data)
                print("done")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
