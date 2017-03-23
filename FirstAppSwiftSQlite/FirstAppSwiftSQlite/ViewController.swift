//
//  ViewController.swift
//  FirstAppSwiftSQlite
//
//  Created by Developer on 12/20/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    private var contacts = [Contact]()
    private var selectedContact: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NameTextField.text = contacts[indexPath].name
        phoneTextField.text = contacts[indexPath].phone
        addressTextField.text = contacts[indexPath].address
        
        selectedContact = indexPath.row
    }
    
}


















