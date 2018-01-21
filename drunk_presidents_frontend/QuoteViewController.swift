//
//  QuoteViewController.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 1/20/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {
    
    var president: President?
    var quote = "Server could not be accessed"
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    @IBAction func refreshButton(_ sender: Any) {
        Network.instance.fetch(route: Route.get_FDR) { (data) in
            print(data)
        }
    }
    @IBAction func savebutton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("initiated")
        getNewQuote()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNewQuote() {
        if let president = president {
            switch president {
            case .FDR:
                print("FDR")
            case .Lincoln:
                print("Lincoln")
            case .Washington:
                print("Washington")
            }
        }
        Network.instance.fetch(route: Route.get_FDR) { (data) in
            
            
        }
        
    }
}
