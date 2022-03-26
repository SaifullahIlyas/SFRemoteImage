//
//  SFRemoteImage-FileManager.swift
//  SFRemoteImage
//
//  Created by Saifullah Ilyas on 26/03/2022.
//

import Foundation


protocol SFFileManageable : AnyObject {
    
}
private extension SFFileManageable {
    var foldername : String {
        get
        {
            return "com.softera.SFRemoteImage"
            
        }
        
    }
}
private extension SFFileManageable {
    func createDirectoryIfNeeded(atFloder folder : String){
      
      guard let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return }
      
      let fileURL = docDirectory.appendingPathComponent("\(folder)")
      if  !FileManager.default.fileExists(atPath: fileURL.path) {
             try? FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: false, attributes: nil)
          }
  }
}


extension SFFileManageable  {
   @discardableResult func saveFile(atDestination path : String,withData  data : Data)->Bool{
       createDirectoryIfNeeded(atFloder: foldername)
       guard let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
       else { return false }
       let udid = UUID().uuidString
       let fileURL = docDirectory.appendingPathComponent("\(foldername)").appendingPathComponent(udid)
       do
       {
           try data.write(to: fileURL)
           UserDefaults.standard.setValue(udid, forKey: path)
       }
       catch
       {
        return false
       }
       
      return true
    }
    @discardableResult func getFileData( withkey key :String)->Data? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            guard let keyValue = UserDefaults.standard.value(forKey: key) as? String
            else {return nil}
            return try?  Data.init(contentsOf: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(foldername).appendingPathComponent(keyValue).absoluteURL)
          
            }
            return nil
    }
}
