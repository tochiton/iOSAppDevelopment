//
//  ViewController.swift
//  TestingPlainSwift
//
//  Created by Developer on 2/16/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchId")
        defaults.set("tochiton", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SaveArray")
        
        let dict = ["Name": "Paul", "County": "UK"]
        defaults.set(dict, forKey: "SaveDict")
        
        let age = defaults.integer(forKey: "Age")
        let name = defaults.string(forKey: "Name")
        print(age)
        print(name!)
        
        let tempArray = (UserDefaults.standard.value(forKey: "SaveArray"))!
        print(tempArray)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}









