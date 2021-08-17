//
//  InfoToAvoidCovidVC.swift
//  FinalProject
//
//  Created by Drashti Akbari on 2020-04-17.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import UIKit

class InfoToAvoidCovidVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblCite: UILabel!
    
    var arrOfPic = [UIImage(named: "img1"),UIImage(named: "img2"),UIImage(named: "img3"),UIImage(named: "img4"),UIImage(named: "img5"),UIImage(named: "img6")]
    var arrOfDescription = ["•  There is currently no vaccine to prevent coronavirus disease 2019 (COVID-19).\n\n•  The best way to prevent illness is to avoid being exposed to this virus.\n\n•  The virus is thought to spread mainly from person-to-person.Between people who are in close contact with one another (within about 6 feet).\n\n\t- Through respiratory droplets produced when an infected person coughs, sneezes or talks.\n\n\t- These droplets can land in the mouths or noses of people who are nearby or possibly be inhaled into the lungs.\n\n\t- Some recent studies have suggested that COVID-19 may be spread by people who are not showing symptoms.","Clean your hands often : \n\n•  Wash your hands often with soap and water for at least 20 seconds especially after you have been in a public place, or after blowing your nose, coughing, or sneezing. \n\n•  If soap and water are not readily available, use a hand sanitizer that contains at least 60% alcohol. Cover all surfaces of your hands and rub them together until they feel dry. \n\n•  Avoid touching your eyes, nose, and mouth with unwashed hands.","Avoid close contact : \n\n•  Avoid close contact with people who are sick \n\n•  Stay home as much as possible. \n\n•  Put distance between yourself and other people. \n\n\t•  Remember that some people without symptoms may be able to spread virus. \n\n\t•  Keeping distance from others is especially important for people who are at higher risk of getting very sick.","Cover your mouth and nose with a cloth face cover when around others \n\n•  You could spread COVID-19 to others even if you do not feel sick. \n\n•  Everyone should wear a cloth face cover when they have to go out in public, for example to the grocery store or to pick up other necessities. \n\n•  Cloth face coverings should not be placed on young children under age 2, anyone who has trouble breathing, or is unconscious, incapacitated or otherwise unable to remove the mask without assistance. \n\n\t•  The cloth face cover is meant to protect other people in case you are infected. \n\n•  Do NOT use a facemask meant for a healthcare worker. \n\n•  Continue to keep about 6 feet between yourself and others. The cloth face cover is not a substitute for social distancing.","Cover coughs and sneezes \n\n•  If you are in a private setting and do not have on your cloth face covering, remember to always cover your mouth and nose with a tissue when you cough or sneeze or use the inside of your elbow. \n\n•  Throw used tissues in the trash. \n\n•  Immediately wash your hands with soap and water for at least 20 seconds. If soap and water are not readily available, clean your hands with a hand sanitizer that contains at least 60% alcohol.","Clean and disinfect \n\n•  Clean AND disinfect frequently touched surfaces daily. This includes tables, doorknobs, light switches, countertops, handles, desks, phones, keyboards, toilets, faucets, and sinks. \n\n•  If surfaces are dirty, clean them. Use detergent or soap and water prior to disinfection. \n\n•  Then, use a household disinfectant. Most common EPA-registered household disinfectant will work."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCite.text = "https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html"
    }
    
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToDescriptionVc(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionVC
        controller.description1 = arrOfDescription[sender.tag]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

class AvoidInfection : UICollectionViewCell {
    @IBOutlet weak var shouldAvoidImg: UIImageView!
    @IBOutlet weak var btnDescription: UIButton!
}

extension InfoToAvoidCovidVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.size.width / 2)
        let cellHeight = (collectionView.frame.size.height / 3)
        return CGSize(width:cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfPic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvoidInfection", for: indexPath as IndexPath) as! AvoidInfection
        cell.shouldAvoidImg.image = arrOfPic[indexPath.row]
        cell.btnDescription.tag = indexPath.row
        return cell
    }
}
