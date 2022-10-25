//
//  ViewController.swift
//  TestingApp
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import UIKit
import GITAPISample

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task{
            do {
                let result = try await GitHubService.getRepoList(platform: "", companyName: "")
                print("result::\(result)")
            } catch {
                print("error::\(error)")
            }
        }
    }


}

