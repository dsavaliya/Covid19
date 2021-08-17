//
//  ViewController.swift
//  FinalProject
//
//  Created by Drashti Akbari on 2020-04-17.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import UIKit
import Charts
import CoreLocation
import GoogleSignIn

class FirstPageVC: UIViewController {
    var locationManager = CLLocationManager()
    var nearestCountryIndex : Int?
    
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblTotalCases: UILabel!
    @IBOutlet weak var lblRecoveredCases: UILabel!
    @IBOutlet weak var lblTotalDeaths: UILabel!
    @IBOutlet weak var lblRecoveredPercentage: UILabel!
    @IBOutlet weak var lblDeathPercentage: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblCountryConfirmedCases: UILabel!
    @IBOutlet weak var lblCountryRecoveredCases: UILabel!
    @IBOutlet weak var lblCountryTotalDeaths: UILabel!
    @IBOutlet weak var visualEffectView: UIView!
    @IBOutlet weak var nearestCountryData: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUsername.text = UserDefaults.standard.string(forKey: "username")
        visualEffectView.isHidden = true
        nearestCountryData.isHidden = true
        fetchCovidData()
        tapGasture()
    }
    
    func tapGasture() {
        let clickUITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onSelect(_:)))
        clickUITapGestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        visualEffectView?.addGestureRecognizer(clickUITapGestureRecognizer)
    }
    
    func getPercentage(_ totalValue : Int,_ currentValue : Int ) -> Double {
        let percentage = (Double(currentValue) / Double(totalValue)) * 100
        return Double(percentage)
    }
    
    func getData(filename fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("I can not read your file \(fileName).json")
                print(error)
            }
        }
        print("I can not read the file \(fileName).json")
        return nil
    }
    
    @IBAction func onSelect(_ sender: Any) {
        visualEffectView.isHidden = true
        nearestCountryData.isHidden = true
    }
    
    @IBAction func btnNearestCountryData(_ sender: Any) {
        visualEffectView.isHidden = false
        nearestCountryData.isHidden = false
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UserDefaults.standard.setValue("", forKey: "logintype")
        UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension FirstPageVC{
    func fetchCovidData() {
        if let data = getData(filename: "covid_data") {
            do {
                let jsonDecoder = JSONDecoder()
                let readableData = try jsonDecoder.decode(CovidData.self, from: data)
                self.chartData(Double(readableData.totalConfirmed), Double(readableData.totalRecovered), Double(readableData.totalDeaths))
                
                self.lblTotalCases.text = "\(readableData.totalConfirmed)"
                self.lblRecoveredCases.text = "\(readableData.totalRecovered)"
                self.lblTotalDeaths.text = "\(readableData.totalDeaths)"
                let recoveredPercentage = self.getPercentage(readableData.totalConfirmed, readableData.totalRecovered)
                self.lblRecoveredPercentage.text = "\(recoveredPercentage.round(to: 2)) %"
                let deathsPercentage = self.getPercentage(readableData.totalConfirmed, readableData.totalDeaths)
                self.lblDeathPercentage.text = "\(deathsPercentage.round(to: 2)) %"
                self.getNearestLocation(readableData.areas)
                self.lblCountry.text = "\(readableData.areas[self.nearestCountryIndex!].displayName)"
                if let nearestCountryConfirmedCases = readableData.areas[self.nearestCountryIndex!].totalConfirmed {
                    self.lblCountryConfirmedCases.text = "Confirmed Case : \(nearestCountryConfirmedCases)"
                }
                if let nearestCountryRecoveredCases = readableData.areas[self.nearestCountryIndex!].totalRecovered {
                    self.lblCountryRecoveredCases.text = "Recovered Case : \(nearestCountryRecoveredCases)"
                }
                if let nearestCountryDeathsCases = readableData.areas[self.nearestCountryIndex!].totalDeaths {
                    self.lblCountryTotalDeaths.text = "Confirmed Case : \(nearestCountryDeathsCases)"
                }
                
            } catch {
                print("Cannot decode your data")
                print(error)
            }
        }
    }
    
    
    func chartData(_ totalCase: Double ,_ recoveredCase: Double, _ totalDeaths: Double) {
        let d1 = BarChartDataEntry(x: 1, y: totalCase)
        let d2 = BarChartDataEntry(x: 2, y: recoveredCase)
        let d3 = BarChartDataEntry(x: 3, y: totalDeaths)
        let dataSet = BarChartDataSet(entries: [d1,d2,d3], label: "Covid-19 Cases")
        dataSet.colors = [.blue,.green,.red]
        
        let chartData = BarChartData(dataSet: dataSet)
        self.barChart.data = chartData
    }
}

extension FirstPageVC : CLLocationManagerDelegate{
    
    func getLocation() -> CLLocationCoordinate2D {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        let location: CLLocation? = locationManager.location
        let coordinate: CLLocationCoordinate2D? = location?.coordinate
        if let aCoordinate = coordinate {
            return aCoordinate
        }
        return CLLocationCoordinate2D()
    }
    
    func getNearestLocation(_ areas : Array<Areas>) {
        var distances = [CLLocationDistance]()
        let coordinate: CLLocationCoordinate2D = self.getLocation()
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let userLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        for index in 0..<areas.count {
            let lat = areas[index].lat
            let long = areas[index].long
            let locationFromData = CLLocation(latitude: lat, longitude: long)
            distances.append(userLocation.distance(from: locationFromData))
        }
        let closest = distances.min()
        nearestCountryIndex = distances.firstIndex(of: closest!)
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

