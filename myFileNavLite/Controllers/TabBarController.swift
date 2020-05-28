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
        guard let docs: DocsController = (VC?[0] as! DocsController) else {
            let docs =  VC?[1] as! DocsController
                let download = VC?[0] as! DownloadController
                download.manager = EventManager(docs)
        }
        
        let download = VC?[1] as! DownloadController
        download.manager = EventManager(docs)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
