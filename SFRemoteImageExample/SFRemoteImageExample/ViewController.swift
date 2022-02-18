//
//  ViewController.swift
//  SFRemoteImageExample
//
//  Created by Saifullah Ilyas on 15/02/2022.
//

import UIKit
import SFRemoteImage

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let url =  "https://media.istockphoto.com/photos/new-luxury-residential-towers-construction-on-the-waterfront-of-east-picture-id1304037325"
    let placeHolder = UIImage(named: "placeholder")
//    lazy var aaa : UIActivityIndicatorView = {
//        let activty =  UIActivityIndicatorView()
//        activty.startAnimating()
//        activty.color = .cyan
//        return activty
//
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        SFRemoteImage.image(fromURL: "https://media.istockphoto.com/photos/new-luxury-residential-towers-construction-on-the-waterfront-of-east-picture-id1304037325"){image, data in 
            
        }
      //  self.imageView.image(fromURL: url, andPlaceHolderImage: placeHolder,shouldShowProgress : true)
      //  self.imageView.image(fromURL: url, andPlaceHolderImage: placeHolder,shouldShowProgress : true)
        
//       var loaderToShow : UIActivityIndicatorView  {
//            let activty =  UIActivityIndicatorView()
//            activty.startAnimating()
//            activty.color = .cyan
//            return activty
//
//        }
//        self.imageView.image(fromURL: url, andPlaceHolderImage: placeHolder, shouldShowProgress:loaderToShow)
        
        
    
        // Do any additional setup after loading the view.
    }


}

