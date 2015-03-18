//
//  SwiftPromptsView.swift
//  Swift-Prompts
//
//  Created by Gabriel Alvarado on 3/15/15.
//  Copyright (c) 2015 Gabriel Alvarado. All rights reserved.
//

import Foundation
import UIKit


//Variables for the prompt with their default values
var promptHeight : CGFloat = 197.0
var promptWidth : CGFloat = 225.0
var promtHeader : String = "Success"
var promptHeaderTxtSize : CGFloat = 20.0
var promptContentText : String = "You have successfully posted this item to your Facebook wall."
var promptContentTxtSize : CGFloat = 18.0
var promptTopBarVisibility : Bool = false
var promptBottomBarVisibility : Bool = true
var promptTopLineVisibility : Bool = true
var promptBottomLineVisibility : Bool = false
var promptOutlineVisibility : Bool = false
//Colors of the items within the prompt
var promptBackgroundColor : UIColor = UIColor.whiteColor()
var promptHeaderBarColor : UIColor = UIColor.clearColor()
var promptBottomBarColor : UIColor = UIColor(red: 34.0/255.0, green: 192.0/255.0, blue: 100.0/255.0, alpha: 1.0)
var promptHeaderTxtColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
var promptContentTxtColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
var promptOutlineColor : UIColor = UIColor.clearColor()
var promptTopLineColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
var promptBottomLineColor : UIColor = UIColor.clearColor()

class SwiftPromptsView: UIView
{
    //Variables for the background view
    var blurringLevel : CGFloat!
    var colorWithTransparency : UIColor!
    var enableBlurring : Bool!
    var enableTransparencyWithColor : Bool!
    var enableLightEffect : Bool!           //Disables enableBlurring and enableTransparencyWithColor
    var enableExtraLightEffect : Bool!      //Disables enableBlurring and enableTransparencyWithColor
    var enableDarkEffect : Bool!            //Disables enableBlurring and enableTransparencyWithColor
    

    override func drawRect(rect: CGRect)
    {
        var backgroundImage : UIImage = snapshot(self.superview)
        var effectImage : UIImage!
        var transparencyAndColorImageView : UIImageView!
        
        //Check the light or dark effects, if all are disabled then enable the custom effects.
        if ((enableLightEffect == nil) && (enableExtraLightEffect == nil) && (enableDarkEffect == nil))
        {
            //Add a blurring effect to the view if enabled.
            if ((enableBlurring) != nil)
            {
                if ((blurringLevel) != nil) {
                    effectImage = backgroundImage.applyBlurWithRadius(blurringLevel, tintColor: nil, saturationDeltaFactor: 1.0, maskImage: nil)
                }
                else {
                    effectImage = backgroundImage.applyBlurWithRadius(5.0, tintColor: nil, saturationDeltaFactor: 1.0, maskImage: nil)
                }
                
                var blurredImageView = UIImageView(image: effectImage)
                self.addSubview(blurredImageView)
            }
            else
            {
                var bgImageView = UIImageView(image: backgroundImage)
                self.addSubview(bgImageView)
            }
            
            //Add a transparency with color effect to the view if enabled.
            if ((enableTransparencyWithColor) != nil)
            {
                if ((colorWithTransparency) != nil) {
                    transparencyAndColorImageView = UIImageView(frame: self.bounds)
                    transparencyAndColorImageView.backgroundColor = colorWithTransparency;
                } else {
                    transparencyAndColorImageView = UIImageView(frame: self.bounds)
                    transparencyAndColorImageView.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.64)
                }
                
                self.addSubview(transparencyAndColorImageView)
            }
        }
        else
        {
            if (enableLightEffect == true)
            {
                effectImage = backgroundImage.applyLightEffect()
                var lightEffectImageView = UIImageView(image: effectImage)
                self.addSubview(lightEffectImageView)
            }
            else if (enableExtraLightEffect == true)
            {
                effectImage = backgroundImage.applyExtraLightEffect()
                var extraLightEffectImageView = UIImageView(image: effectImage)
                self.addSubview(extraLightEffectImageView)
            }
            else if (enableDarkEffect == true)
            {
                effectImage = backgroundImage.applyDarkEffect()
                var darkEffectImageView = UIImageView(image: effectImage)
                self.addSubview(darkEffectImageView)
            }
            else
            {
                var snapShotImageView = UIImageView(image: backgroundImage)
                self.addSubview(snapShotImageView)
            }
        }
        
        //Create the prompt and assign its size and position
        var promptSize = CGRect(x: 0, y: 0, width: promptWidth, height: promptHeight)
        var swiftPrompt = PromptBoxView(frame: promptSize)
        swiftPrompt.backgroundColor = UIColor.clearColor()
        swiftPrompt.center = CGPointMake(self.center.x, self.center.y)
        self.addSubview(swiftPrompt)        
        
        //Apply animation effect to present this view
        var applicationLoadViewIn = CATransition()
        applicationLoadViewIn.duration = 0.4
        applicationLoadViewIn.type = kCATransitionReveal
        applicationLoadViewIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.layer.addAnimation(applicationLoadViewIn, forKey: kCATransitionReveal)
    }
    
    // MARK: - Helper Functions
    func snapshot(view: UIView!) -> UIImage!
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        var image : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    // MARK: - API Functions
    func setBlurringLevel(level: CGFloat) { blurringLevel = level }
    func setColorWithTransparency(color: UIColor) { colorWithTransparency = color }
    func enableBlurringView () { enableBlurring = true }
    func enableTransparencyWithColorView () { enableTransparencyWithColor = true }
    func enableLightEffectView () { enableLightEffect = true; enableExtraLightEffect = false; enableDarkEffect = false }
    func enableExtraLightEffectView () { enableLightEffect = false; enableExtraLightEffect = true; enableDarkEffect = false }
    func enableDarkEffectView () { enableLightEffect = false; enableExtraLightEffect = false; enableDarkEffect = true }
    
}

class PromptBoxView: UIView
{
    override func drawRect(rect: CGRect)
    {
        SwiftPrompts.drawSwiftPrompt(frame: self.bounds, backgroundColor: promptBackgroundColor, headerBarColor: promptHeaderBarColor, bottomBarColor: promptBottomBarColor, headerTxtColor: promptHeaderTxtColor, contentTxtColor: promptContentTxtColor, outlineColor: promptOutlineColor, topLineColor: promptTopLineColor, bottomLineColor: promptBottomLineColor, promptText: promptContentText, textSize: promptContentTxtSize, topBarVisibility: promptTopBarVisibility, bottomBarVisibility: promptBottomBarVisibility, headerText: promtHeader, headerSize: promptHeaderTxtSize, topLineVisibility: promptTopLineVisibility, bottomLineVisibility: promptBottomLineVisibility, outlineVisibility: promptOutlineVisibility)
    }
}