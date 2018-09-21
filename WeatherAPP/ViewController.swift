//
//  ViewController.swift
//  WeatherAPP
//
//  Created by adika on 9/20/18.
//  Copyright © 2018 adika. All rights reserved.
//

import UIKit
import LocationPickerViewController
import OpenWeatherMapAPIConsumer
import CoreLocation


class ViewController: UIViewController, LocationPickerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var weatherIconImage: UIImageView!
    @IBOutlet var areaLabel: UILabel!
    @IBOutlet var cloudLabel: UILabel!
    @IBOutlet var tmpBtn: UIButton!
    
    let iconUrl = "http://openweathermap.org/img/w/"
    let apikeyWeather = "f80a4403a1983a8aba664af023535daa"
    
    var locationManager: CLLocationManager = CLLocationManager()
    var locationObject: CLLocation?
    
    
    var responseWeatherApi : ResponseOpenWeatherMapProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getCurrentLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseTemp(_ sender: UIButton) {
        if tmpBtn.isSelected == true{
            tmpBtn.isSelected = false
        }else{
            tmpBtn.isSelected = true
        }
        print("123")
        
        let currentLatitude: CLLocationDistance = self.locationObject!.coordinate.latitude
        let currentLongitude: CLLocationDistance = self.locationObject!.coordinate.longitude
        
        self.setAPIWEATHER(latitude: currentLatitude, with: currentLongitude)
    }
    
    func openLocationPage(){
        let locationPicker = LocationPicker()
        
        locationPicker.addBarButtons()
        // Call this method to add a done and a cancel button to navigation bar.
        
        locationPicker.pickCompletion = { (pickedLocationItem) in
            // Do something with the location the user picked.
            self.setAPIWEATHER(latitude: (pickedLocationItem.coordinate?.latitude)!, with: (pickedLocationItem.coordinate?.longitude)!)
            print(pickedLocationItem.name)
        }
        
        let navigationController = UINavigationController(rootViewController: locationPicker)
        present(navigationController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func showLocationPage(_ sender: UIButton) {
        self.openLocationPage()
    }
    
    func setAPIWEATHER(latitude : Double, with longitude:Double){
        let weatherAPI = OpenWeatherMapAPI(apiKey: apikeyWeather , forType: OpenWeatherMapType.Current)
        var stringDegree = ""
        
        if self.tmpBtn.isSelected == true{
            weatherAPI.setTemperatureUnit(unit: TemperatureFormat.Fahrenheit)
            stringDegree = "°F"
        }else{
            weatherAPI.setTemperatureUnit(unit: TemperatureFormat.Celsius)
            stringDegree = "°C"
        }
        
        weatherAPI.weather(byLatitude: latitude, andLongitude: longitude)
        
        self.view.activityStartAnimating(activityColor: UIColor.orange, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        
        weatherAPI.performWeatherRequest(completionHandler:{(data: Data?, urlResponse: URLResponse?, error: Error?) in
            if (error != nil) {
                //Handling error
            } else {
                do {
                    let dt = WeatherData(object: data as Any)
                    
                    DispatchQueue.main.async { [unowned self] in
                        self.tempLabel.text = String(Int((dt.main?.temp)!)) + stringDegree
                        self.downloadImage(from: dt.weather![0].icon!)
                        self.areaLabel.text = String(self.getDateTime() + " " + dt.name!)
                        self.cloudLabel.text = dt.weather![0].main!
                    }
                    
                } catch let error as Error {
                    //Handling error
                    return
                }
            }
        })
        
        self.view.activityStopAnimating()
    }
    
    func downloadImage(from url: String) {
        let stringurlimage = String(self.iconUrl + url + ".png")
        print(stringurlimage)
        let urlimage = URL(string: stringurlimage)
        getData(from: urlimage!) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? urlimage?.lastPathComponent as Any)
            DispatchQueue.main.async() {
                self.weatherIconImage.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getDateTime() -> String{
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMM"
        let result = formatter.string(from: date)
        
        return result
    }
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if self.locationObject == nil {
            self.locationObject = locations[locations.count - 1]
            let currentLatitude: CLLocationDistance = self.locationObject!.coordinate.latitude
            let currentLongitude: CLLocationDistance = self.locationObject!.coordinate.longitude
            
            self.setAPIWEATHER(latitude: currentLatitude, with: currentLongitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        NSLog("Impossible to get the location of the device")
    }
    
}



extension UIView{
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    
}

