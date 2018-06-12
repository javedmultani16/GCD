//
//  ViewController.swift
//  GCD_Swift
//
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    enum Method:Int{
        
        case Normal_Way = 0
        case Dispatch_Concurrent_Queues = 1
        case Dispatch_Serial_Queues
        case Dispatch_async_queue
        case Dispatch_sync_queue
        case NSOperation_Queues
    }
    
    
    @IBOutlet weak var tblList: UITableView!
    var arrayURL = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblList.delegate = self
        self.tblList.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: tableview delegate method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:simpleTableViewCell? = tableView.dequeueReusableCell(withIdentifier:"simpleTableViewCell") as? simpleTableViewCell
        if cell == nil{
            tableView.register(UINib.init(nibName: "simpleTableViewCell", bundle: nil), forCellReuseIdentifier: "simpleTableViewCell")
            let arrNib:Array = Bundle.main.loadNibNamed("simpleTableViewCell",owner: self, options: nil)!
            cell = arrNib.first as? simpleTableViewCell
        }
        
        if let newRow = Method(rawValue: indexPath.row) {
            switch newRow {
                
            case .Normal_Way :
                 cell?.labelName.text = "Normal"
                break
            case .Dispatch_Concurrent_Queues :
                 cell?.labelName.text = "Dispatch Concurrent Queues"
                break
            case .Dispatch_Serial_Queues :
                 cell?.labelName.text = "Dispatch Serial Queues"
                break
        
            case .Dispatch_sync_queue :
                 cell?.labelName.text = "Dispatch Sync Queue"
                break
            case .Dispatch_async_queue:
                 cell?.labelName.text = "Dispatch Async Queue"
                break
            case .NSOperation_Queues:
                 cell?.labelName.text = "NSOperation Queues"
                break
            
                
            }
        }
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        //  vc.strName = self.arrayFruit[indexPath.row]
        vc.intSelectedType = indexPath.row
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

