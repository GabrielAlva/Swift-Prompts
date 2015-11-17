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
        
        //Set the background view image
        backgroundImageView.image = UIImage(named: "Alps")
        backgroundImageView.contentMode = .ScaleAspectFill
    }

    @IBAction func facebookPrompt(sender: UIButton)
    {
        //Create an instance of SwiftPromptsView and assign its delegate
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Set the properties for the background
        prompt.setBlurringLevel(2.0)
        prompt.setColorWithTransparency(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.64))
        
        //Set the properties of the prompt
        prompt.setPromptHeader("Facebook")
        prompt.setPromptTopBarVisibility(true)
        prompt.setPromptBottomBarVisibility(false)
        prompt.setPromptTopLineVisibility(false)
        prompt.setPromptBottomLineVisibility(true)
        prompt.setPromptHeaderBarColor(UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 0.67))
        prompt.setPromptHeaderTxtColor(UIColor.whiteColor())
        prompt.setPromptContentTxtColor(UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 0.72))
        prompt.setPromptBottomLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.setMainButtonText("ok")
        prompt.setImage(UIImage(named: "test-image-3"))
        
        self.view.addSubview(prompt)
    }
    
    @IBAction func whatsAppPrompt(sender: UIButton)
    {
        //Create an instance of SwiftPromptsView and assign its delegate
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Set the properties for the background
        prompt.setColorWithTransparency(UIColor.clearColor())
        
        //Set the properties of the prompt
        prompt.setPromptHeader("WhatsApp")
        prompt.setPromptContentText("Would you like to send this image through WhatsApp?")
        prompt.setPromptTopBarVisibility(true)
        prompt.setPromptBottomBarVisibility(false)
        prompt.setPromptTopLineVisibility(false)
        prompt.setPromptBottomLineVisibility(true)
        prompt.setPromptHeaderBarColor(UIColor(red: 100.0/255.0, green: 212.0/255.0, blue: 72.0/255.0, alpha: 1.0))
        prompt.setPromptHeaderTxtColor(UIColor.whiteColor())
        prompt.setPromptBottomLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.setPromptButtonDividerColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.enableDoubleButtonsOnPrompt()
        prompt.setMainButtonText("Send")
        prompt.setSecondButtonText("Cancel")
        prompt.setImage(UIImage(named: "test-image-1"))
        
        self.view.addSubview(prompt)
    }
    
    @IBAction func successPrompt(sender: UIButton)
    {
        //Create an instance of SwiftPromptsView and assign its delegate
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Set the properties for the background
        prompt.enableLightEffectView()
        
        //Set the properties of the prompt
        prompt.setPromptHeader("Success")
        prompt.setPromptContentText("The photo was successfully saved to your camera roll and your media library.")
        prompt.setPromptTopLineVisibility(true)
        prompt.setPromptBottomLineVisibility(false)
        prompt.setPromptBottomBarVisibility(true)
        prompt.setPromptTopLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.setPromptBackgroundColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.67))
        prompt.setPromptBottomBarColor(UIColor(red: 34.0/255.0, green: 139.0/255.0, blue: 34.0/255.0, alpha: 0.67))
        prompt.setMainButtonColor(UIColor.whiteColor())
        prompt.setMainButtonText("OK")
        prompt.setImage(UIImage(named: "test-image-3"))
        
        self.view.addSubview(prompt)
    }
    
    @IBAction func instagramPrompt(sender: UIButton)
    {
        //Create an instance of SwiftPromptsView and assign its delegate
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Set the properties for the background
        prompt.enableDarkEffectView()
        
        //Set the properties of the prompt
        prompt.setPromptHeader("Instagram")
        prompt.setPromptContentText("Would you like to post this photo to Instagram?")
        prompt.setPromptDismissIconVisibility(true)
        prompt.setPromptTopLineVisibility(false)
        prompt.setPromptBottomLineVisibility(true)
        prompt.setPromptTopBarVisibility(true)
        prompt.setPromptBottomBarVisibility(false)
        prompt.setPromptOutlineVisibility(true)
        prompt.setPromptHeaderBarColor(UIColor(red: 177.0/255.0, green: 109.0/255.0, blue: 68.0/255.0, alpha: 1.0))
        prompt.setPromptHeaderTxtColor(UIColor(red: 255.0/255.0, green: 253.0/255.0, blue: 195.0/255.0, alpha: 1.0))
        prompt.setPromptDismissIconColor(UIColor(red: 255.0/255.0, green: 253.0/255.0, blue: 195.0/255.0, alpha: 1.0))
        prompt.setPromptOutlineColor(UIColor(red: 177.0/255.0, green: 109.0/255.0, blue: 68.0/255.0, alpha: 1.0))
        prompt.setPromptBackgroundColor(UIColor(red: 255.0/255.0, green: 253.0/255.0, blue: 195.0/255.0, alpha: 1.0))
        prompt.setMainButtonColor(UIColor(red: 177.0/255.0, green: 109.0/255.0, blue: 68.0/255.0, alpha: 1.0))
        prompt.setPromptBottomLineColor(UIColor(red: 177.0/255.0, green: 109.0/255.0, blue: 68.0/255.0, alpha: 1.0))
        prompt.setImage(UIImage(named: "test-image-2"))
        
        self.view.addSubview(prompt)
    }
    
    @IBAction func deletePrompt(sender: UIButton)
    {
        //Create an instance of SwiftPromptsView and assign its delegate
        prompt = SwiftPromptsView(frame: self.view.bounds)
        prompt.delegate = self
        
        //Set the properties for the background
        prompt.enableExtraLightEffectView()
        
        //Set the properties of the prompt
        prompt.setPromptHeader("Delete")
        prompt.setPromptContentText("Would you like to remove this item permanently from your library?")
        prompt.setPromptTopLineVisibility(true)
        prompt.setPromptBottomLineVisibility(false)
        prompt.setPromptBottomBarVisibility(true)
        prompt.setPromptDismissIconVisibility(true)
        prompt.setPromptOutlineVisibility(true)
        prompt.setPromptHeaderTxtColor(UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0))
        prompt.setPromptOutlineColor(UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0))
        prompt.setPromptDismissIconColor(UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0))
        prompt.setPromptTopLineColor(UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0))
        prompt.setPromptBackgroundColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.67))
        prompt.setPromptBottomBarColor(UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0))
        prompt.setMainButtonColor(UIColor.whiteColor())
        prompt.setMainButtonText("Delete")
        prompt.setImage(UIImage(named: "test-image-1"))
        
        self.view.addSubview(prompt)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    // MARK: - Delegate functions for the prompt
    
    func clickedOnTheMainButton() {
        print("Clicked on the main button")
        prompt.dismissPrompt()
    }
    
    func clickedOnTheSecondButton() {
        print("Clicked on the second button")
        prompt.dismissPrompt()
        
    }
    
    func promptWasDismissed() {
        print("Dismissed the prompt")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

