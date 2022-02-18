//
//  SFRemoteImage+Protoco-GCDWrapper.swift
//  SFRemoteImage
//
//  Created by Saifullah Ilyas on 18/02/2022.
//

import Foundation

protocol GCDWrapper : AnyObject {
    
}
extension GCDWrapper {
    static   func  runOnMainQueue(completion : @escaping ()->())  {
        let queue = DispatchQueue.main
        queue.async {
            completion()
        }
    }
    
}
