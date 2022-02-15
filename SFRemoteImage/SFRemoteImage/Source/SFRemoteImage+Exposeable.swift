//
//  SFRemoteImage.swift
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit




//MARK:- Exposeable
public extension SFRemoteImage  {
    class func image(fromURL : String, completion : onImageResult) {
     let dowLoader = SFRemoteImage.shared
     dowLoader.download(url: fromURL, completion: completion)
     }
     
     class func image(fromURL url : String,intoImageView imageView : UIImageView?){
         let dowLoader = SFRemoteImage.shared
         
         dowLoader.download(url: url) { image, _ in
             let queue = DispatchQueue.main
             queue.async {
                 imageView?.image = image
             }
            
         }
     }
}
