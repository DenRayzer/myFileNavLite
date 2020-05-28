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
    private var docsBuffer: [Document] = []
    private var links: [(URL?,Bool)] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLinks()
        collectionView.register(UINib(nibName: DownloadCell.reuseId, bundle: nil), forCellWithReuseIdentifier: DownloadCell.reuseId)
    }
    
    func getLinks() {
        let rawLink = Bundle.main.decode([JSONData].self, from: "data.json")
        for i in 0..<rawLink.count {
            let str = rawLink[i].url
            links.append((URL.init(string:str)!,false))
        }
    }
    
    @IBAction func downloadAll(_ sender: Any) {
        var isfileDownload = true
        DispatchQueue.global().async {
            let dg = DispatchGroup()
            dg.enter()
            DispatchQueue.concurrentPerform(iterations: self.links.count) { (i) in
                if(!self.links[i].1) {
                    isfileDownload = false
                    self.downloadDoc(indexPath: IndexPath(item: i, section: 0),downloadAll: true)
                }
            }
            dg.leave()
            dg.notify(queue: .main) {
                if isfileDownload {
                    self.alert(title: "There are no files to download")
                } else {
                    for i in 0..<self.docsBuffer.count {
                        self.manager?.notifyDownloadFinished(data: self.docsBuffer[i])
                    }
                }
            }
        }
    }
    
    func alert(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DownloadController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DownloadCell.reuseId, for: indexPath) as! DownloadCell
        cell.linkLabel.text = links[indexPath.item].0?.lastPathComponent
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(!links[indexPath.item].1) {
            DispatchQueue.global().async {
                self.downloadDoc(indexPath: indexPath,downloadAll: false)
            }
        } else {
            alert(title: "this file has already been downloaded")
        }
    }
    
    func downloadDoc(indexPath: IndexPath, downloadAll: Bool) {
        DispatchQueue.main.async {
            if self.collectionView.cellForItem(at: indexPath) != nil {
                let cell = self.collectionView.cellForItem(at: indexPath) as! DownloadCell
                cell.indicator.isHidden = false
                cell.indicator.startAnimating()
            }
        }
        
        guard let url = links[indexPath.item].0 else { return  }
        do {
            let dg = DispatchGroup()
            dg.enter()
            let data = try Data(contentsOf: url)
            let localUrl = saveDoc(url: url, data: data)
            dg.leave()
            
            dg.notify(queue: .main) {
                DispatchQueue.main.async {
                    if self.collectionView.cellForItem(at: indexPath) != nil {
                        let cell = self.collectionView.cellForItem(at: indexPath) as! DownloadCell
                        cell.indicator.stopAnimating()
                    }
                }
                
                let newDoc =  Document(docUrl: localUrl, docName: url.lastPathComponent, docSize: data.count)
                self.links[indexPath.item].1 = true
                
                // if downloadAll save downloaded doc in buffer
                if downloadAll {
                    self.docsBuffer.append(newDoc)
                } else {
                    self.manager?.notifyDownloadFinished(data: newDoc)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveDoc(url: URL, data: Data) -> URL {
        let docName = url.lastPathComponent
        let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = docDirectoryURL.appendingPathComponent(docName)
        try? data.write(to: destinationUrl, options: .atomic)
        return destinationUrl
    }
    
}
