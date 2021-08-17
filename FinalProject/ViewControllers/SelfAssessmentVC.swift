//
//  SelfAssessmentVC.swift
//  FinalProject
//
//  Created by Drashti Akbari on 2020-04-18.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import UIKit

class SelfAssessmentVC: UIViewController {
    
    var arrOfTitle = ["Are you experiencing any of the following:", "Are you experiencing any of the following:", "Do you have any of the following:", "In the past 14 days, did you return from travel outside of Canada, or did you have close contact with someone who is confirmed as having COVID-19?"]
    var arrOfDescription = ["\n•  severe difficulty breathing (e.g., struggling for each breath, speaking in single words) \n•  severe chest pain\n•  having a very hard time waking up\n•  feeling confused \n•  lost consciousness", "\n•  shortness of breath at rest \n•  inability to lie down because of difficulty breathing \n•  chronic health conditions that you are having difficulty managing because of your current respiratory illness", "\n•  fever\n•  cough\n•  shortness of breath\n•  difficulty breathing\n•  sore throat\n•  runny nose", ""]
    var numOfQuestion = 0
    
    @IBOutlet weak var lblCite : UILabel!
    @IBOutlet weak var lblTitleOfQuestion: UILabel!
    @IBOutlet weak var lblDescriptionOfQuestion: UILabel!
    @IBOutlet weak var btnYes : UIButton!
    @IBOutlet weak var btnNo : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCite.text = "https://myhealth.alberta.ca/Journey/COVID-19/Pages/Assessment.aspx"
        lblTitleOfQuestion.text = arrOfTitle[numOfQuestion]
        lblDescriptionOfQuestion.text = arrOfDescription[numOfQuestion]
    }
    
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnYes(_ sender: Any) {
        btnNo.isHidden = true
        btnYes.isHidden = true
        lblTitleOfQuestion.textColor = UIColor.red
        lblTitleOfQuestion.font = lblTitleOfQuestion.font.withSize(25)
        lblTitleOfQuestion.text = "Please call 911 or go directly to your nearest emergency department."
        lblDescriptionOfQuestion.text = ""
    }
    
    @IBAction func btnNo(_ sender: Any) {
        numOfQuestion += 1
        if numOfQuestion < arrOfTitle.count {
            lblTitleOfQuestion.text = arrOfTitle[numOfQuestion]
            lblDescriptionOfQuestion.text = arrOfDescription[numOfQuestion]
        }
        else {
            btnNo.isHidden = true
            btnYes.isHidden = true
            lblTitleOfQuestion.text = "THANK YOU FOR ASSESSMENT"
            lblDescriptionOfQuestion.text = "You don't need to be tested for COVID-19."
        }
    }
}
