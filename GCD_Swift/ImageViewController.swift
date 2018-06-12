//
//  ImageViewController.swift
//  GCD_Swift
//
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var intSelectedType = 0
    var arrayURL = [String]()
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        arrayURL = ["http://designroot.in/uploads/project/croped/time-square-6.jpg",
                    "http://designroot.in/uploads/project/croped/shiven-square-2.jpg",
                    "http://designroot.in/uploads/project/croped/shiven-square-3.jpg",
                    "http://designroot.in/uploads/project/croped/shiven-square-4.jpg"]
        
        // Do any additional setup after loading the view.
    }
    func setData(){
        
        switch intSelectedType {
        case 0:  //Normal Way
            
            let img = downloadImage(arrayURL[0])
            self.img1.image = img
            
            let img1 = downloadImage(arrayURL[1])
            self.img2.image = img1
            
            let img2 = downloadImage(arrayURL[2])
            self.img3.image = img2
            
            let img3 = downloadImage(arrayURL[3])
            self.img4.image = img3
            break
            
        case 1://Using Concurrent Dispatch Queues
            let aQueue = DispatchQueue.global(qos: .default)
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[0])
                DispatchQueue.main.async(execute: {() -> Void in
                    self.img1.image = img
                })
            })
            
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[1])
                DispatchQueue.main.async(execute: {() -> Void in
                    self.img2.image = img
                })
            })
            
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[2])
                DispatchQueue.main.async(execute: {() -> Void in
                    self.img3.image = img
                })
            })
            
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[3])
                DispatchQueue.main.async(execute: {() -> Void in
                    self.img4.image = img
                })
            })
            
            break
        case 2://Using Serial Dispatch Queues
            let aQueue: DispatchQueue = DispatchQueue(label: "com.GCD-Swift")
            
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[0])
                DispatchQueue.main.async(execute: {() -> Void in
                    self.img1.image = img
                })
            })
            
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[1])
                DispatchQueue.main.async(execute: {() -> Void in
                    self.img2.image = img
                })
            })
            
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[2])
                DispatchQueue.main.async(execute: {() -> Void in
                    self.img3.image = img
                })
            })
            
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[3])
                DispatchQueue.main.async(execute: {() -> Void in
                    self.img4.image = img
                })
            })
            break
            
        case 3://dispatch_async Methods
            let aQueue = DispatchQueue.global(qos: .default)
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[0])
                DispatchQueue.main.async(execute: {() -> Void in
                    print("1")
                    self.img1.image = img
                })
            })
            
            DispatchQueue.main.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[1])
                self.img2.image = img
            })
            aQueue.async(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[2])
                DispatchQueue.main.async(execute: {() -> Void in
                    print("3")
                    self.img3.image = img
                })
            })
            print("4")
            DispatchQueue.main.async(execute: {() -> Void in
                let img22: UIImage? = self.downloadImage(self.arrayURL[3])
                self.img4.image = img22
            })
            
            
            break
            
        case 4: //dispatch_sync Methods
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(1) / Double(NSEC_PER_SEC), execute: {() -> Void in
            })
            
            let aQueue = DispatchQueue.global(qos: .default)
            
            aQueue.sync(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[0])
                self.img1.image = img
                print("1")
            })
            print("2")
            aQueue.sync(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[1])
                self.img2.image = img
            })
            aQueue.sync(execute: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[2])
                print("3")
                self.img3.image = img
            })
            print("4")
            aQueue.sync(execute: {() -> Void in
                let img22: UIImage? = self.downloadImage(self.arrayURL[3])
                self.img4.image = img22
            })
            
            break
            
        case 5: //NSOperation & Operation Queues
            img1.image = nil
            img2.image = nil
            img3.image = nil
            img4.image = nil
            let queue = OperationQueue()
            let operation1 = BlockOperation(block: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[0])
                OperationQueue.main.addOperation({() -> Void in
                    self.img1.image = img
                })
            })
            operation1.queuePriority = .veryLow
            operation1.completionBlock = {() -> Void in
                print("\("Operation 1 completed, cancelled: \(operation1.isCancelled)")")
            }
            queue.addOperation(operation1)
            
            let operation2 = BlockOperation(block: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[1])
                OperationQueue.main.addOperation({() -> Void in
                    self.img2.image = img
                })
            })
            operation2.completionBlock = {() -> Void in
                print("\("Operation 2 completed, cancelled: \(operation2.isCancelled)")")
            }
            queue.addOperation(operation2)
            operation2.addDependency(operation1)
            
            let operation3 = BlockOperation(block: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[2])
                OperationQueue.main.addOperation({() -> Void in
                    self.img3.image = img
                })
            })
            operation3.completionBlock = {() -> Void in
                print("\("Operation 3 completed, cancelled: \(operation3.isCancelled)")")
            }
            queue.addOperation(operation3)
            
            
            let operation4 = BlockOperation(block: {() -> Void in
                let img: UIImage? = self.downloadImage(self.arrayURL[3])
                OperationQueue.main.addOperation({() -> Void in
                    self.img4.image = img
                })
            })
            operation4.queuePriority = .veryHigh
            operation4.completionBlock = {() -> Void in
                print("\("Operation 4 completed, cancelled: \(operation4.isCancelled)")")
            }
            queue.addOperation(operation4)
            
            
            
            break
            
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonHandlerStart(_ sender: Any) {
        self.setData()
    }
    

    @IBAction func buttonHandlerCancel(_ sender: Any) {
        
    }
    
    //MARK: custom method
    
    func downloadImage(_ url: String?) -> UIImage? {
        var data: Data? = nil
        if let anUrl = URL(string: url ?? "") {
            data = NSData(contentsOf: anUrl) as Data? //Data(contentsOf: anUrl)
        }
        if let aData = data {
            return UIImage(data: aData)
        }
        return nil
    }


}
