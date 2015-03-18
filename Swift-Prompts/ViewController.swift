//
//  ViewController.swift
//  Swift-Prompts
//
//  Created by Gabriel Alvarado on 3/15/15.
//  Copyright (c) 2015 Gabriel Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display the background view image
        backgroundImageView.image = UIImage(named: "SpaceShuttle")
        backgroundImageView.contentMode = .ScaleAspectFill
    }

    @IBAction func launchPrompt(sender: UIButton) {
        var prompt = SwiftPromptsView(frame: self.view.bounds)
        
        //Enable blurring and add its level of blur
        prompt.enableBlurringView()
        prompt.setBlurringLevel(2.0)
        
        //Enable a transparency with color view and set its values
        prompt.enableTransparencyWithColorView()
        prompt.setColorWithTransparency(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.64))
        
        promtHeader = "Facebook"
        promptTopBarVisibility = true
        promptBottomBarVisibility = false
        promptTopLineVisibility = false
        promptBottomLineVisibility = true
        promptHeaderBarColor = UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 0.67)
        promptHeaderTxtColor = UIColor.whiteColor()
        promptContentTxtColor = UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 0.72)
        promptBottomLineColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        
        self.view.addSubview(prompt)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

