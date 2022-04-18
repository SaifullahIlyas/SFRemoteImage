//
//  SFRemoteImage.swift
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit


enum OperationState {
    case waitingToDownload
    case downloading
    case finished
    case cancelled
    case failed
}
protocol NeedsOperationQueue {
    
}
extension NeedsOperationQueue{
    func defaulOptQueue()->OperationQueue {
        let queue : OperationQueue = OperationQueue()
        queue.name = "com.sfremoteimage.opqueue"
        queue.qualityOfService = .userInteractive
        queue.maxConcurrentOperationCount = 4
        return queue
    }
    func optQueue(withIdentifier idf : String)->OperationQueue {
        let queue : OperationQueue = OperationQueue()
        queue.name = idf
        queue.qualityOfService = .userInteractive
        return queue
    }
}

final public class SFRemoteImage : NSObject,NeedsOperationQueue,GCDWrapper,SFFileManageable{
    
    private lazy var tQueue  = defaulOptQueue()
    private let internalQueue = DispatchQueue(label: "com.imagedownloaderinternal.queue",
                                              qos: .default,
                                              attributes: .concurrent)
    private var operationLookup : [String:DownLoadOperation] = [:]
    /*These list will be used to invoke multiple completion when same url downloaded requested for more than 1 time**/
    private var blocksToInvokeOnCompletion : [String : [onImageResult]] = [:]
    
   public typealias onImageResult = ((UIImage?,Data?)->Void)?
    
    //chache
    private let cache = NSCache<NSString, NSData>()
    
    static var shared = SFRemoteImage()
    private override init() {
        
    }
     func download(url : String,completion :onImageResult){
        //return image from cache if already downloaded
        if let cachedData = self.cache.object(forKey: url as NSString){
            completion?(UIImage(data: cachedData as Data),cachedData as Data)
            //tryRefreshData(at: url, completion: completion)
        }
         //check if image is in diskstorage
         else if let diskData = self.getFileData(withkey: url) {
             completion?(UIImage(data: diskData ),diskData)
             tryRefreshData(at: url, completion: completion)
         }
        else
        {
            tryRefreshData(at: url, completion: completion)
            
            
        }
        
        
    }
    
    private func tryRefreshData(at url : String,completion :onImageResult) {
        //check already running operation
        if let operation = self.getOperationAtURL(url: url), let blocks = self.getBlocks(atURL: url){
            operation.queuePriority = .high
            
            self.updateBlocks(atURL: url, andBlocks: blocks + [completion])
        }
        // define new task
        else
        {
            let operation = DownLoadOperation(url: url,state: .waitingToDownload)
            tQueue.addOperation(operation)
            operation.imageForOperation = {image,data in
                                           if let data = data {
                                            self.cache.setObject(data as NSData , forKey: operation.url as NSString)
                                               self.saveFile(atDestination: operation.url, withData: data)
                                                               }
                guard let blocks = self.getBlocks(atURL: url) else {return}
                for block in blocks {
                    block?(image,data)
                }
                self.removeBlocks(atURL: url)
                self.removeOperations(atURL: url)
                
            }
            self.updateOperationAtURL(url: url, operation: operation)
            self.updateBlocks(atURL: url, andBlocks:  [completion])
            
            
       }
        
    }
    
    /*Thread Safe operations*/
    private func removeOperations(atURL url : String) {
        internalQueue.async(group: nil, qos: .default, flags: .barrier) {
            self.operationLookup.removeValue(forKey: url)
        }
    }
    private func removeBlocks(atURL url : String) {
        internalQueue.async(group: nil, qos: .default, flags: .barrier) {
            self.blocksToInvokeOnCompletion[url]?.removeAll()
        }
    }
  
    private func getBlocks(atURL url : String)->[onImageResult]? {
        internalQueue.sync(flags: .barrier) {
            self.blocksToInvokeOnCompletion[url]
        }
    }
    private func updateBlocks(atURL url : String , andBlocks blocks : [onImageResult]) {
        internalQueue.async(group: nil, qos: .default, flags: .barrier) {
            self.blocksToInvokeOnCompletion[url] = blocks
        }
    }
    private func getOperationAtURL(url : String)->DownLoadOperation? {
        internalQueue.sync(flags: .barrier) {
            return self.operationLookup[url]
        }
    }
    private func updateOperationAtURL(url : String,operation : DownLoadOperation) {
        internalQueue.async(group: nil, qos: .default, flags: .barrier) {
            self.operationLookup[url] =  operation
        }
    }
  
}

