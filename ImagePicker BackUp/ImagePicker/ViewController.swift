//
//  ViewController.swift
//  ImagePicker
//
//  Created by Developer on 1/5/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagesDirectoryPath: String!
    var images: [UIImage]!
    var titles: [String]!
    
    
    @IBAction func choosePhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        present(imagePicker, animated: true, completion: nil)
        imagePicker.delegate = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        images = []
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectorPath:String = paths[0]
        
        //creates the path
        imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        var objecBool : ObjCBool = true
        
        //checks if the file exits already
        let isExit = FileManager.default.fileExists(atPath: imagesDirectoryPath)
        print( (paths[0]))
        // creates a file under imageDirectoryPath
        if isExit == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
                    print("File created")
            }catch{
                print("Something went wrong while creating folder")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage ,didFinishPickingMediaWithInfo info: [String : Any]) {
        
    
        var imagePath = NSDate().description
        imagePath = imagePath.replacingOccurrences(of: " ", with: "")
        // possible error appending the string
        imagePath = imagesDirectoryPath.appending("/\(imagePath).png")
        let data = UIImagePNGRepresentation(image)
        // check documemtation for the argument Data vs data
        let success = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        dismiss(animated: true, completion: { () -> Void in self.refreshTable()})
    }
    
    func refreshTable(){
        do{
            images.removeAll()
            titles = try FileManager.default.contentsOfDirectory(atPath: imagesDirectoryPath)
            for image in titles{
                let data = FileManager.default.contents(atPath: imagesDirectoryPath.appending("/\(image)"))
                let image = UIImage(data: data!)
                images.append(image!)
            }
            self.tableView.reloadData()
        }catch{
            print("Error")
        }
    }
  /*
    func UITableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> UITableViewCell{
        <#code#>
    }
    */

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CellID")
        cell?.imageView?.image = images[indexPath.row]
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
}
























