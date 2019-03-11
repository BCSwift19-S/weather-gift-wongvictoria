//
//  DetailedVC.swift
//  WeatherGift
//
//  Created by Victoria Wong on 3/10/19.
//  Copyright © 2019 Victoria Wong. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    var currentPage = 0
    var locationsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = locationsArray[currentPage]

    }
    


}
