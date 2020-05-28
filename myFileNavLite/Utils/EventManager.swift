//
//  EventManager.swift
//  myFileNavLight
//
//  Created by Елизавета on 27.05.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class EventManager {
    
let listener: DownloadObserver
   
   init(_ listener: DownloadObserver) {
       self.listener = listener
   }
   
    func notifyDownloadFinished(data: Data) {
        listener.setNewItem(data: data)
   }

}
