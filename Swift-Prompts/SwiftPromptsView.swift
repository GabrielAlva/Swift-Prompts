//
//  SwiftPromptsView.swift
//  Swift-Prompts
//
//  Created by Gabriel Alvarado on 3/15/15.
//  Copyright (c) 2015 Gabriel Alvarado. All rights reserved.
//

import Foundation
import UIKit

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
    
    //Other variables
    var enableDoubleButtons : Bool = false
    var buttonText : String = "Post"
    var secondButtonText : String = "Cancel"
    var buttonColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    var secondButtonColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    
    override func drawRect(rect: CGRect)
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
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
        var swiftPrompt = PromptBoxView(master: self)
        swiftPrompt.backgroundColor = UIColor.clearColor()
        swiftPrompt.center = CGPointMake(self.center.x, self.center.y)
        self.addSubview(swiftPrompt)
        
        //Add the button(s) on the bottom of the prompt
        if (enableDoubleButtons == false)
        {
            let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
            button.frame = CGRectMake(0, promptHeight-52, promptWidth, 41)
            button.setTitleColor(buttonColor, forState: .Normal)
            button.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            button.setTitle(buttonText, forState: UIControlState.Normal)
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    
            swiftPrompt.addSubview(button)
        }
        else
        {
            var divider = UIView(frame: CGRectMake(promptWidth/2, promptHeight-47, 1, 31))
            divider.backgroundColor = promptBottomLineColor
            
            swiftPrompt.addSubview(divider)
            
            let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
            button.frame = CGRectMake(promptWidth/2, promptHeight-52, promptWidth/2, 41)
            button.setTitleColor(buttonColor, forState: .Normal)
            button.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            button.setTitle(buttonText, forState: UIControlState.Normal)
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
            swiftPrompt.addSubview(button)
            
            let secondButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
            secondButton.frame = CGRectMake(0, promptHeight-52, promptWidth/2, 41)
            secondButton.setTitleColor(secondButtonColor, forState: .Normal)
            secondButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            secondButton.setTitle(secondButtonText, forState: UIControlState.Normal)
            secondButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
            swiftPrompt.addSubview(secondButton)
        }
        
        //Apply animation effect to present this view
        var applicationLoadViewIn = CATransition()
        applicationLoadViewIn.duration = 0.4
        applicationLoadViewIn.type = kCATransitionReveal
        applicationLoadViewIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.layer.addAnimation(applicationLoadViewIn, forKey: kCATransitionReveal)
    }
    
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
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
    
    func orientationChanged()
    {
        self.removeFromSuperview()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - API Functions For The Background
    func setBlurringLevel(level: CGFloat) { blurringLevel = level }
    func setColorWithTransparency(color: UIColor) { colorWithTransparency = color }
    func enableBlurringView () { enableBlurring = true }
    func enableTransparencyWithColorView () { enableTransparencyWithColor = true }
    func enableLightEffectView () { enableLightEffect = true; enableExtraLightEffect = false; enableDarkEffect = false }
    func enableExtraLightEffectView () { enableLightEffect = false; enableExtraLightEffect = true; enableDarkEffect = false }
    func enableDarkEffectView () { enableLightEffect = false; enableExtraLightEffect = false; enableDarkEffect = true }
    
    // MARK: - API Functions For The Prompt
    func setPromptHeight (height : CGFloat) { promptHeight = height }
    func setPromptWidth (width : CGFloat) { promptWidth = width }
    func setPromtHeader (header : String) { promtHeader = header }
    func setPromptHeaderTxtSize (headerTxtSize : CGFloat) { promptHeaderTxtSize = headerTxtSize }
    func setPromptContentText (contentTxt : String) { promptContentText = contentTxt }
    func setPromptContentTxtSize (contentTxtSize : CGFloat) { promptContentTxtSize = contentTxtSize }
    func setPromptTopBarVisibility (topBarVisibility : Bool) { promptTopBarVisibility = topBarVisibility }
    func setPromptBottomBarVisibility (bottomBarVisibility : Bool) { promptBottomBarVisibility = bottomBarVisibility }
    func setPromptTopLineVisibility (topLineVisibility : Bool) { promptTopLineVisibility = topLineVisibility }
    func setPromptBottomLineVisibility (bottomLineVisibility : Bool) { promptBottomLineVisibility = bottomLineVisibility }
    func setPromptOutlineVisibility (outlineVisibility: Bool) { promptOutlineVisibility = outlineVisibility }
    func setPromptBackgroundColor (backgroundColor : UIColor) { promptBackgroundColor = backgroundColor }
    func setPromptHeaderBarColor (headerBarColor : UIColor) { promptHeaderBarColor = headerBarColor }
    func setPromptBottomBarColor (bottomBarColor : UIColor) { promptBottomBarColor = bottomBarColor }
    func setPromptHeaderTxtColor (headerTxtColor  : UIColor) { promptHeaderTxtColor =  headerTxtColor}
    func setPromptContentTxtColor (contentTxtColor : UIColor) { promptContentTxtColor = contentTxtColor }
    func setPromptOutlineColor (outlineColor : UIColor) { promptOutlineColor = outlineColor }
    func setPromptTopLineColor (topLineColor : UIColor) { promptTopLineColor = topLineColor }
    func setPromptBottomLineColor (bottomLineColor : UIColor) { promptBottomLineColor = bottomLineColor }
    func enableDoubleButtonsOnPrompt () { enableDoubleButtons = true }
    func setButtonText (buttonTitle : String) { buttonText = buttonTitle }
    func setSecondButtonText (secondButtonTitle : String) { secondButtonText = secondButtonTitle }
    func setButtonColor (colorForButton : UIColor) { buttonColor = colorForButton }
    func setSecondButtonColor (colorForSecondButton : UIColor) { secondButtonColor = colorForSecondButton }
    
    
    // MARK: - Create The Prompt With A UIView Sublass
    class PromptBoxView: UIView
    {
        //Mater Class
        let masterClass : SwiftPromptsView
        
        //Gesture Recognizer Vars
        var lastLocation:CGPoint = CGPointMake(0, 0)
        
        init(master: SwiftPromptsView) {
            masterClass = master
            var promptSize = CGRect(x: 0, y: 0, width: masterClass.promptWidth, height: masterClass.promptHeight)
            super.init(frame: promptSize)
            
            // Initialization Gesture Recognizer
            var panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
            self.gestureRecognizers = [panRecognizer]
        }

        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func drawRect(rect: CGRect)
        {
            SwiftPrompts.drawSwiftPrompt(frame: self.bounds, backgroundColor: masterClass.promptBackgroundColor, headerBarColor: masterClass.promptHeaderBarColor, bottomBarColor: masterClass.promptBottomBarColor, headerTxtColor: masterClass.promptHeaderTxtColor, contentTxtColor: masterClass.promptContentTxtColor, outlineColor: masterClass.promptOutlineColor, topLineColor: masterClass.promptTopLineColor, bottomLineColor: masterClass.promptBottomLineColor, promptText: masterClass.promptContentText, textSize: masterClass.promptContentTxtSize, topBarVisibility: masterClass.promptTopBarVisibility, bottomBarVisibility: masterClass.promptBottomBarVisibility, headerText: masterClass.promtHeader, headerSize: masterClass.promptHeaderTxtSize, topLineVisibility: masterClass.promptTopLineVisibility, bottomLineVisibility: masterClass.promptBottomLineVisibility, outlineVisibility: masterClass.promptOutlineVisibility)
        }
        
        func detectPan(recognizer:UIPanGestureRecognizer) {
            var translation  = recognizer.translationInView(self)
            self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
            
            var verticalDistanceFromCenter : CGFloat = fabs(translation.y)
            var horizontalDistanceFromCenter : CGFloat = fabs(translation.x)
            var shouldDismissPrompt : Bool = false
            
            println("X Point: \(horizontalDistanceFromCenter) Y Point: \(verticalDistanceFromCenter)")
            
            if (verticalDistanceFromCenter < 100.0) {
                var radiusAlphaLevel : CGFloat = 1.0 - verticalDistanceFromCenter/100
                self.alpha = radiusAlphaLevel
                shouldDismissPrompt = false
            } else {
                self.alpha = 0.0
                shouldDismissPrompt = true
            }
            
            if (recognizer.state == UIGestureRecognizerState.Ended) {
                if (shouldDismissPrompt == true) {
                    UIView.animateWithDuration(0.6, animations: {
                        self.layer.opacity = 0.0
                        self.masterClass.layer.opacity = 0.0
                        }, completion: {
                            (value: Bool) in
                            self.removeFromSuperview()
                            self.masterClass.removeFromSuperview()
                    })
                } else {
                    UIView.animateWithDuration(0.3, animations: {
                        self.center = self.masterClass.center
                        self.alpha = 1.0
                    })
                }
            }
        }
        
        override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
        {
            // Remember original location
            lastLocation = self.center
        }
    }
}












