//
//  ViewController.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 1/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
enum President {
    case Washington
    case Lincoln
    case FDR
}

class ViewController: UIViewController {

    var president: President?
    
    @IBAction func washingtonButton(_ sender: Any) {
        self.president = President.Washington
        self.performSegue(withIdentifier: "toQuote", sender: president)
    }
    
    @IBAction func lincolnButton(_ sender: Any) {
        self.president = President.Lincoln
        self.performSegue(withIdentifier: "toQuote", sender: president)
    }
    
    @IBAction func fDRButton(_ sender: Any) {
        self.president = President.FDR
        self.performSegue(withIdentifier: "toQuote", sender: president)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toQuote" {
                let quoteViewController = segue.destination as! QuoteViewController
                quoteViewController.president = self.president
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

