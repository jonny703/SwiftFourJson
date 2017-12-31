//
//  ViewController.swift
//  SwiftFourJson
//
//  Created by John Nik on 10/9/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?

    
    //enable to remove for swift 4 function
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        link = json["link"] as? String ?? ""
        imageUrl = json["imageUrl"] as? String ?? ""
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.handleOneCourseOldMethode()
        self.handleOneCourse()
        self.handleMultiCourses()
        self.handleWebsiteDescription()
        self.handleMissingJsondata()
    }
    
    func handleMissingJsondata() {
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 ok
            
            guard let data = data else { return }
            
            do {
                
                let course = try JSONDecoder().decode([Course].self, from: data)
                
                print(course)
                
            } catch let jsonErr {
                print("Error serializing error: ", jsonErr)
            }
            }.resume()
    }
    
    func handleWebsiteDescription() {
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 ok
            
            guard let data = data else { return }
            
            do {
                
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription.name, websiteDescription.description)
                
            } catch let jsonErr {
                print("Error serializing error: ", jsonErr)
            }
        }.resume()
    }
    
    func handleMultiCourses() {
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 ok
            
            guard let data = data else { return }
            
            do {
                
                let course = try JSONDecoder().decode([Course].self, from: data)
                
                print(course)
            } catch let jsonErr {
                print("Error serializing error: ", jsonErr)
            }
            
        }.resume()
    }
    
    func handleOneCourse() {
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 ok
            
            guard let data = data else { return }
            
            do {
                
                let course = try JSONDecoder().decode(Course.self, from: data)
                
                print(course.name)
            } catch let jsonErr {
                print("Error serializing error: ", jsonErr)
            }
            }.resume()
    }
    
    func handleOneCourseOldMethode() {
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 ok
            
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString!)
            
            do {
                
                //Swift 2/3/Objc
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                print(json)
                
                let course = Course(json: json)
                print(course.name)
            } catch let jsonErr {
                print("Error serializing error: ", jsonErr)
            }
            }.resume()
    }
}

