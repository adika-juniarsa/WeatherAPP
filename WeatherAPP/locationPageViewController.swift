//
//  locationPageViewController.swift
//  WeatherAPP
//
//  Created by febi on 9/21/18.
//  Copyright © 2018 adika. All rights reserved.
//

import UIKit
import LocationPickerViewController

class locationPageViewController: LocationPicker {

    override func viewDidLoad() {
        super.viewDidLoad()
//        super.addBarButtons()
        
        self.addBarButtons()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func locationDidSelect(locationItem: LocationItem) {
//        // Do something with user's every selection.
//    }
//    
//    override func locationDidPick(locationItem: LocationItem) {
//        // Do something with the location the user picked.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
