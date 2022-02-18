# SFRemoteImage

SFRemoteImage is a lightweight thread-safe image downloading and caching library built on the top of NSOperationQueue.
## Availability 
 It supports currently  **iOS 9+.**

# Installation Guide
SFRemoteImage is available through cocoapods and swift package manager.
## Cocoapods
- Add to podfile 
``` 
 pod 'SFRemoteImage'
 
 ```
 - Install  by running  
 ```
 pod install 
 
 ```
 
 ## Swift Package Manager
 
# Usage
SFRemoteImage available through imageview instance method as well as through facade method of 
SFRemoteImage by importing 
```
import  SFRemoteImage

```


## ImageView Instance method
```
image(fromURL: , andPlaceHolderImage: , shouldShowProgress:)

```
- ``` fromURL(required) ``` is URL String of remote image available on Server.
- ``` andPlaceHolderImage(optional) ``` is the placeholder Image to show on imageView while downloading or after downloading if no image is found in the provided URL.
- ``` shouldShowProgress(optional) ``` can either be a bool value to show default activity indicator or a custom view to show as progress on imageview while downloading.
### Example Usage For ImageView
```self.imageView.image(fromURL: url, andPlaceHolderImage: placeHolder,shouldShowProgress : true)```

Or By Passing Custom Loader

```

var loaderToShow : UIActivityIndicatorView  {
     let activty =  UIActivityIndicatorView()
     activty.startAnimating()
     activty.color = .cyan
     return activty
     
 }
  self.imageView.image(fromURL: url, andPlaceHolderImage: placeHolder, shouldShowProgress:loaderToShow)
  
  ```
  
  ## SFRemoteImage Fecade method
   ``` image(fromURL : String, completion : onImageResult) ```
   - ``` fromURL(required) ``` url to download Image .
   - ``` completion(required) ``` is colosure that accept  UIImage,Data
   
   ``` image(fromURL url : String,intoImageView imageView : UIImageView?,andPlaceHolderImage placeholderImage : UIImage?) ```
   
   - ``` fromURL(required) ``` url to downloadImage
   - ``` intoImageView(optional) ``` imageview in which you want to display the image after download.
   - ``` placeholderImage(optional) ``` is the placeholder Image to show on imageView while downloading or after downloading if no image is found in the provided URL.
   ### Example Usage  as a Facade Method
   ```
   
   SFRemoteImage.image(fromURL: URLString, intoImageView: imageView,andPlaceHolderImage: placeHolder))
   
   ```
   or by 
   
   ```
   
   SFRemoteImage.image(fromURL: url){image, data in 
   
   }
   
   ```
   
  



