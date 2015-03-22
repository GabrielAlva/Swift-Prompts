//
//  ViewController.swift
//  Swift-Prompts
//
//  Created by Gabriel Alvarado on 3/15/15.
//  Copyright (c) 2015 Gabriel Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  SwiftPromptsProtocol{

    @IBOutlet var backgroundImageView: UIImageView!
    
    var prompt = SwiftPromptsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display the background view image
        backgroundImageView.image = UIImage(named: "SpaceShuttle")
        backgroundImageView.contentMode = .ScaleAspectFill
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    @IBAction func launchPrompt(sender: UIButton)
    {
        //Create an instance of SwiftPromptsView in a var
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Enable blurring and add its level of blur
        prompt.setBlurringLevel(2.0)
        
        //Enable a transparency with color view and set its values
        prompt.setColorWithTransparency(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.64))
        
        //Set the properties of the promt to look as desired
        prompt.setPromtHeader("Facebook")
        prompt.setPromptTopBarVisibility(true)
        prompt.setPromptBottomBarVisibility(false)
        prompt.setPromptTopLineVisibility(false)
        prompt.setPromptBottomLineVisibility(true)
        prompt.setPromptHeaderBarColor(UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 0.67))
        prompt.setPromptHeaderTxtColor(UIColor.whiteColor())
        prompt.setPromptContentTxtColor(UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 0.72))
        prompt.setPromptBottomLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.enableDoubleButtonsOnPrompt()
        
        self.view.addSubview(prompt)
    }
    
    func rotated()
    {
        prompt.removeFromSuperview()
    }
    
    func clickedOnTheMainButton() {
        println("Clicked on the main button")
    }
    
    func clickedOnTheSecondButton() {
        println("Clicked on the second button")
        prompt.dismissPrompt()
        
    }
    
    func promptWasDismissed() {
        println("Dismissed view")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

