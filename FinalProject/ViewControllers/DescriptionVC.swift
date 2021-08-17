//
//  DescriptionVC.swift
//  FinalProject
//
//  Created by Drashti Akbari on 2020-04-17.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {
    
    var description1 = ""
    @IBOutlet weak var txtDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDescription.text = description1
        txtDescription.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
    }
    
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func share(_ sender: Any) {
        let myWebsite = NSURL(string: "https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html")
        guard let url1 = myWebsite
            else {
                print("nothing found")
                return
        }
        let shareItems:Array = [description1, url1] as [AnyObject]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
    }
}
