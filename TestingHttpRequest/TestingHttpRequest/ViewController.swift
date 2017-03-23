//
//  ViewController.swift
//  TestingHttpRequest
//
//  Created by Developer on 2/14/17.
//  Copyright © 2017 Developer. All rights reserved.
//

/*
 
 This is my learning interface/planning session
 
 This enviroment is for learning process where
 I can experiment the different methods and solutions
 
 learning curve need to be efficient and fast
 work always on side projects --> key: passive income
 
 */


import UIKit
import CoreData

class ViewController: UIViewController {

    let login_url = "http://row52-beta.azurewebsites.net/Api/V1/Account/Authenticate"
    let checksession_url = "http://row52-beta.azurewebsites.net/Api/V1/Account/TokenIsValid"
    
    // you can declare any varible in this block but you need to initialize it
    var container: NSPersistentContainer!
    
    var login_session:String = ""
    
    
    func login_now(username:String, password:String)
    {
        //declare a dictionary and access through the value post_data
        //initialize the dictionary
        let post_data: NSDictionary = NSMutableDictionary()
        
        
        post_data.setValue(username, forKey: "Username")
        post_data.setValue(password, forKey: "Password")
        
        let url:URL = URL(string: login_url)!
        let session = URLSession.shared    // initialize url session
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        
        
        for (key, value) in post_data
        {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        //encode in the http body, the dictionary by specifying the variable name + the data
        // encode that into utf8
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
          
            let responseData = String(data: data!, encoding: String.Encoding.utf8)
            print(responseData!)
          
            
            if responseData != nil{
                self.login_session = responseData!
                let preferences = UserDefaults.standard
                preferences.set(responseData!, forKey: "session")
                
                
                if let mySession = preferences.value(forKey: "session"){
                    print(mySession)
                    print("Login_Now: Writing the following token into UserDefault")
                }
            }
            let httpResponse = response as! HTTPURLResponse
            
            if httpResponse.statusCode == 200{
                print("we are good")
            }
            else{
                print("Unable to access")
            }
           // print(httpResponse.statusCode)
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                print("returning here")
                return
            }
            // redo it from scratch -- figure out the return value 
            // that's what you store in the session as Authentication
            
            let json: Any?
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                print("getting here")
            }
            catch
            {
                return
            }
            
            guard let server_response = json as? NSDictionary else
            {
                return
            }
            
            print("getting here")
            if let data_block = server_response["data"] as? NSDictionary
            {
                if let session_data = data_block["session"] as? String
                {
                    self.login_session = session_data
                    
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async(execute: self.LoginDone)
                }
            }

            
        })
        
        task.resume()
        
    }
    func check_session()
    {
        let post_data: NSDictionary = NSMutableDictionary()
        
        post_data.setValue(login_session, forKey: "session")
        
        let preferences = UserDefaults.standard
        var myLocalSession: String = ""
        if let mySession = preferences.value(forKey: "session"){
            myLocalSession = mySession as! String
            print("Firt flag -- check session --get session UserDefault")
        }
        
        let url:URL = URL(string: checksession_url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        
        myLocalSession = String(myLocalSession.characters.dropLast())
        myLocalSession = String(myLocalSession.characters.dropFirst())
    
        
        request.setValue("Spider " + myLocalSession, forHTTPHeaderField: "Authorization")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        print(request.value(forHTTPHeaderField: "Authorization")!)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            print("Second flag -- check session -- making http request")
            
            let httpResponse = response as! HTTPURLResponse
            
            if httpResponse.statusCode == 200{
                print("Authenticated -- OK")
                //fire here the next screen
                DispatchQueue.main.async(execute: self.LoginDone)
            }
            else{
                print("Not able to authenticate from check_session")
                print(httpResponse.statusCode)
                //DispatchQueue.main.async(execute: self.LoginToDo)
            }
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
            let json: Any?
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
                return
            }
            
            guard let server_response = json as? NSDictionary else
            {
                return
            }
            
            if let response_code = server_response["response_code"] as? Int
            {
                if(response_code == 200)
                {
                    DispatchQueue.main.async(execute: self.LoginDone)
                    
                }
                else
                {
                    //DispatchQueue.main.async(execute: self.LoginToDo)
                }
            }
            
        })
        
        task.resume()
        
        
    }

    
    func LoginDone()
    {
        print("Loging successfully")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*TESTING NEW CODE FOR GOOD PRACTICE*/

        let possibleString: String? = "an optinal string"
        let forcedString: String = possibleString!
        
        let assumedString: String! = "An implicitly unwrapped optional"
        let implicitString: String = assumedString
        
        // if an implicitly unwrapped optional is nil and you try to access it
        // you try to access it, get a runtime error
        
        if assumedString != nil{
            print(assumedString)
        }
        
        // you can use optional binding to check if it is not nil
        
        if let definiteString = assumedString{
            print(definiteString)
        }
        
        // to indicate, it throws an error, add it to the header of the function
        
        // when you call a function that can throw an error, you prepend the try keyword
        
        func makeASandwich() throws {
            
        }
        
        // a do statement creates a new containing scope, which allows to propagate to more 
        // than one catch block
        
        // assertion
        
        let age = -3
      
        
        let contentHeight = 40;
        
        let hasHeader = true
        
        let rowHeight = contentHeight + (hasHeader ? 50 : 20)
        
        // short circuit evaluation 
        
        let defaultColor = "red"

        var userDefinedColorName: String?
        
        var colorNameToUse = userDefinedColorName ?? defaultColor
        
        // range operator
        //closed range operator (a..b)
        
        for index in 1...5 {
            print("\(index) time 5 is \(index * 5)")
        }
        
        var emptyString = ""
        
        if emptyString.isEmpty{
            //execute this operation
        }
        
            // used the .append method for string to add characters
        
        
        var someInts = [Int]()
        someInts.append(3)
        
        //clean array
        
        someInts = []
        
        // array of literals 
        
        var shoppingList: [String] = ["Eggs", "Rice"]
        
        //inserting at specific index
        
        shoppingList.insert("Honey", at: 0)
        
        // iterating over array
        
        for item in shoppingList{
            print(item)
        }
        
        let oddDigits: Set = [1,3,5,7,9]
        let evenDigits: Set = [0,2,4,6,8]
        
        let singleDigitPrimeNumber: Set = [2,3,5,7]
        
        oddDigits.union(evenDigits).sorted()
        
        oddDigits.intersection(evenDigits).sorted()
        
        
        //buscar bala men...la pelota the Carlota
        //no hay otra menor!!
        //$80k ya estamos an la pelea
        
        var nameOfIntegers = [Int: String]()            //pass() to construct the value
        nameOfIntegers[16] = "sixteen"
        
        
        var airports: [String: String] = ["YYZ": "Toronto", "DUB": "Dublin"]
        
        airports.updateValue("Dublin Airport", forKey: "DUB")
        
        airports["XYZ"] = nil        // dealocate that value
        
        
        // to check the dictionary for a particular key
        
        if let airportName = airports["DUB"]{
            print("The airport names is \(airportName)")
        }else{
            print("It's not in the dictionary")
        }
        
        // iterating over a dictionary 
        
        for(airportCode, airportName) in airports{
            print(airportCode + airportName)
        }
        
        // if you need to use a dictionary of keys or values with an API that takes an array 
        
        let airportCodeArray = [String](airports.keys) //builds an array of keys from a dictionary
        
        print(airportCodeArray)
        
        let somechart: Character = "z"
        
        switch somechart {
        case "a":
            print("first letter of the alphabet")
        case "b":
            print("second letter of the alphabet")
        default:
            print("some other letter")
            print("another")
        }
        
        // in the switch block each block need an executable statement
        // otherwise it will produce a compile time error
        // you can add multiple in case stamement by case "a", "A": 
        // follow by executable statement
        
        // you can use some internal matching 
        
        let approximateAccount = 62
        
        switch approximateAccount {
        case 1..<12:
             print("in the range")
        case 15..<100:
            print("also in the range")
        default:
            print("not in the range")
        }
        
        //working with tuples
        
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let(x,y) where x==y:
            print("X and Y is on the line")
        case let(x, y) where x == -y:
            print("still in the line")
        default:
            print("on progress")
        }
        
        
        /*  
                Books to get: 
                    Clean code
         
                Find books about Tech StartUps
         
                - cleaning some tabs
                - upload files to the server
                - set up core data **** CRUD OPERATION ****
                - improve table view functionalities 
                - control view flows by display different content depending on the input
                - give it a month to come up with a demo 
                    - set up the pace in order to achieve greatness
                    - everything or nothing that's the reality
         
         
                SUMMARY:    
                        - core data
         
                GOALS:
                        - is Making 80k good enough?
                        - After completion of the app, you need to have an intermediate level 
                            How to achieve this: finish Stanforfd tutorial 
                                                    * Implement the project alone
                                                    * Download new lectures with materials  
                                                    * Best tutorial ever -- therefore you need to finish it
                                                    * Improve your online learning skills       
                        - I'm hungry of knowledge 
                        - How are you going to learn chinese?
         */
        
        
        func greet (person: String) -> String{
            let greeting = "Hello" + person + "!"
            return greeting
        }
        

        
        // function with multiples arguments
        
        func greet(person: String, alreadyGreeted: Bool) -> String{
            if alreadyGreeted {
                return greet(person: person)
            }else{
                return greet(person: person)
            }
        }
        
        // return a tuple...a tuple is type of multiples values
        // pass in an array and return a tuple
        // it returns an optional if no value is created
        func minMax(array: [Int]) -> (min: Int, max: Int)? {
            var currentMin = array[0]
            var currentMax = array[0]
            
            for value in array[1..<array.count]{
                if value < currentMin{
                    currentMin = value
                }else if value > currentMax{
                    currentMax = value
                }
            }
            return(currentMin, currentMax)
        }
        // a tuple is a row basically with multiples values and you can access its components
        // by calling the name for the returning type
        // when you call the function, you need to bind with let to in case, it returns nil
        // you need to use optional binding to call the function, this is only way
        // basically the bound variable cast either to nill or to a tuple
        // each funtion has a paramenter name and an argument label
        
        if let bounds = minMax(array: [43,54,22,35,543]){
            print("The min is \(bounds.min) + \(bounds.max)")
            
        }
        
        // Importing core data
        // working with tables
        // working with stack views -- dynamic content
        // the create the flow and pass data around
        // autoLayout for the design 
        // deploy it to the app store
        
        //adding some logic to it should not be that bad... that's the reality
        
        
        /*
            How does core data work under the hood
                - load the model into NSManagedObjectModel
                - create an NSPersistentStoreCoordinator -- responsible for reading and writing
                - set up the url to point to the db in actual memory
            
            all the steps above are consolidated in NSPersistentContainer
                    allocate the container first of type NSPersistentContainer
                    Import the coreData
         
         */
        
        container = NSPersistentContainer(name: "Project38")
        container.loadPersistentStores{ storeDescription, error in
            if let error = error{
                print("Unsolved\(error)")
            }
            
        }
        
        func saveContext(){
            if container.viewContext.hasChanges{
                do{
                    try container.viewContext.save()
                }catch{
                    print("Error while saving files: \(error)")
                }
            }
        }
        
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") != nil
        {
            login_session = preferences.object(forKey: "session") as! String
            print(login_session)
            print("somthing in the UseDefault session")
            
        }
        else
        {
            print("Nothing in the userDefault")
            
            
        }
        print("Calling now")
        login_now(username: "spencer@row52.com", password: "password1")
        sleep(10)
        check_session()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Testing side

}




func testing(){
    var welcome: String
    welcome = "Hello"
    
    // A tuple contains many types
    let http404error = (404, "Not Found")
    
    let (statusCode, statusMessage) = http404error
    
    print("this is the status message\(statusMessage)")
    
    print("statuscode\(http404error.0)")

    //you can name individual names in a tuple
    
    let anotherHttp = (statusCode: 200, description: "Ok")
    
    let possibleNumber = "123"
    // returns an optional to see if it can cast the value from String to Int
    let convertNumber = Int(possibleNumber)
    
    var red,green, blue: Double
    
    //How to unwrap an optional
    var convertible: Int?
    
    if convertible != nil{
        print(convertible!)
    }
    //optional binding to find out whether an optional contains a value and make that value
    //available as temporary constant or variable
    
    if let actualNumber = Int(possibleNumber){
        print("it was able to convert\(actualNumber)")
    }else{
        print("Couldn't convert the value")
    }
}













































