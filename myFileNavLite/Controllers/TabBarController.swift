//
//  TabBarController.swift
//  myFileNavLight
//
//  Created by Елизавета on 27.05.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let VC = self.viewControllers
        let docs = VC?[0] as! DocsController
        let download = VC?[1] as! DownloadController
        download.manager = EventManager(docs)
    }
    
}
