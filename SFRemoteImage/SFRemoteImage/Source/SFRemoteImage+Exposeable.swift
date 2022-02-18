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
            runOnMainQueue {
                imageView?.image = image
            }
            
        }
    }
    class func image(fromURL url : String,intoImageView imageView : UIImageView?,andPlaceHolderImage placeholderImage : UIImage?){
        runOnMainQueue {
            imageView?.image = placeholderImage
        }
        image(fromURL: url) { image, _ in
            runOnMainQueue {
                if let image = image {
                    imageView?.image = image
                }
                else
                {
                    imageView?.image = placeholderImage
                }
            }
        }
        
    }
}
//MARK:- MARK:- Exposeable for imageView
public extension UIImageView   {
    func image(fromURL url : String,andPlaceHolderImage placeholderImage : UIImage?) {
        SFRemoteImage.image(fromURL: url, intoImageView: self, andPlaceHolderImage: placeholderImage)
    }
    func image(fromURL url : String,andPlaceHolderImage placeholderImage : UIImage?,shouldShowProgress shouldShow : Bool) {
        let main  = DispatchQueue.main
        main.async {self.image = placeholderImage}
        if shouldShow
        {
            self.image(fromURL: url, andPlaceHolderImage: placeholderImage, shouldShowProgress: self.progressView())
        }
        else
        {
            self.image(fromURL: url, andPlaceHolderImage: placeholderImage, shouldShowProgress: nil)
        }
    }
    func image(fromURL url : String,andPlaceHolderImage placeholderImage : UIImage?,shouldShowProgress progress : UIView?) {
        let main  = DispatchQueue.main
        main.async {
            self.image = placeholderImage
            if let progress = progress {
                progress.center = self.center
                self.addSubview(progress)
                self.layoutIfNeeded()
                
            }
            
        }
        
        
        SFRemoteImage.image(fromURL: url) { image, _ in
            main.async {
                if let image = image
                {
                    self.image = image
                }
                else
                {
                    self.image = placeholderImage
                }
                progress?.removeFromSuperview()
            }
        }
    }
    
}


extension UIImageView  {
    func progressView()->UIActivityIndicatorView {
        let activity = UIActivityIndicatorView()
        activity.startAnimating()
        return activity
    }
}

