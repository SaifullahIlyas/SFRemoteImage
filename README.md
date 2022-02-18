# SFRemoteImage

SFRemoteImage  is a light weight thread safe image dowloading and caching library buillt on the top of  NSoperation Queue. 
## Availability 
 it support currently  iOS 9+

# Installation Guide
SFRemoteImage is available through cocoapods and swift package manager
## Cocoapods
- add to cocoapods  
 pod 'SFRemoteImage'
 - install pod by running  pod install  from terminal
 
 ## Swift Package Manager
 
# Usage
SFRemoteImage available through imageview instance method as well as through facade method of 
SFRemoteImage by importing 
import  SFRemoteImage


## ImageView Instance method
image(fromURL: , andPlaceHolderImage: , shouldShowProgress:)
->fromURL(required) is url String of remote image available on Server
->andPlaceHolderImage(optional) is the placeholder Image to show on imageView while downloading or after downloading if no image is found the provided url.
-> shouldShowProgress(optional) can either be a bool value to show default activty indicator or a custom view to show to show as progress on imagevview while downloading
### Example Usage For ImageView
self.imageView.image(fromURL: url, andPlaceHolderImage: placeHolder,shouldShowProgress : true)
Or By Passing Custom Loader
var loaderToShow : UIActivityIndicatorView  {
     let activty =  UIActivityIndicatorView()
     activty.startAnimating()
     activty.color = .cyan
     return activty
     
 }
  self.imageView.image(fromURL: url, andPlaceHolderImage: placeHolder, shouldShowProgress:loaderToShow)
  
  ## SFRemoteImage Fecade method
   image(fromURL : String, completion : onImageResult)
   -> fromURL(required) url to downloadImage
   ->completion(required) is colosure that return UIImage,Data
   image(fromURL url : String,intoImageView imageView : UIImageView?,andPlaceHolderImage placeholderImage : UIImage?)
   - fromURL(required) url to downloadImage
   - intoImageView(optional) imageview in which you want to display image after download
   - placeholderImage(optional) is the placeholder Image to show on imageView while downloading or after downloading if no image is found the provided url.
   ### Example Usage For as a Facade Method
   SFRemoteImage.image(fromURL: URLString, intoImageView: imageView,andPlaceHolderImage: placeHolder))
   or by 
   SFRemoteImage.image(fromURL: url){image, data in 
   
   }
   
  



