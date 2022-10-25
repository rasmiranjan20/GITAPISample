//
//  ViewController.swift
//  TestingApp
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import UIKit
import GITAPISample

class ViewController: UIViewController {

    @IBOutlet weak var textPlatform: UITextField!
    @IBOutlet weak var textCompanyName: UITextField!
    @IBOutlet weak var buttonFetch: UIButton!
    @IBOutlet weak var textVLogs: UITextView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func testInSwift() {
        Task{
            do {
                let repos = try await GitHubService.getRepoList(platform: textPlatform.text ?? "", companyName: textCompanyName.text ?? "")
                DispatchQueue.main.async {[weak self] in
                 let logs = "Test in Swift:: repos::\(repos)"
                    self?.textVLogs.text = logs
                    print(logs)
                }
            } catch {
                let logs = "Test in Swift:: error::\(error)"
                textVLogs.text = logs
                print(logs)
            }
        }
    }
    
    func testInObjC() {
        CheckRepoParsing.gitRepoParsing(textPlatform.text ?? "", companyName: textCompanyName.text ?? "") { repos, error in
            DispatchQueue.main.async {[weak self] in
                let logs = "Test in ObjC:: repos::\(String(describing: repos)), error::\(String(describing: error))"
             self?.textVLogs.text = logs
             print(logs)
            }
        }
    }
    
    @IBAction func buttonTapped() {
        textVLogs.text = ""
        if segment.selectedSegmentIndex == 0 {
            testInSwift()
        } else {
            testInObjC()
        }
    }
}

