//
//  SwiftPromptsView.swift
//  Swift-Prompts
//
//  Created by Gabriel Alvarado on 3/15/15.
//  Copyright (c) 2015 Gabriel Alvarado. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SwiftPromptsProtocol {
    optional func clickedOnTheMainButton()
    optional func clickedOnTheSecondButton()
    optional func promptWasDismissed()
}

public class SwiftPromptsView: UIView {
    //Delegate var
    public var delegate : SwiftPromptsProtocol?
    
    //Variables for the background view
    private var blurringLevel : CGFloat = 5.0
    private var colorWithTransparency = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.64)
    private var enableBlurring : Bool = true
    private var enableTransparencyWithColor : Bool = true
    
    //Variables for the prompt with their default values
    private var promptHeight : CGFloat = 197.0
    private var promptWidth : CGFloat = 225.0
    private var promptHeader : String = "Success"
    private var promptHeaderTxtSize : CGFloat = 20.0
    private var promptContentText : String = "You have successfully posted this item to your Facebook wall."
    private var promptContentTxtSize : CGFloat = 18.0
    private var promptTopBarVisibility : Bool = false
    private var promptBottomBarVisibility : Bool = true
    private var promptTopLineVisibility : Bool = true
    private var promptBottomLineVisibility : Bool = false
    private var promptOutlineVisibility : Bool = false
    private var promptButtonDividerVisibility : Bool = true
    private var promptDismissIconVisibility : Bool = false
    
    //Colors of the items within the prompt
    private var promptBackgroundColor : UIColor = UIColor.whiteColor()
    private var promptHeaderBarColor : UIColor = UIColor.clearColor()
    private var promptBottomBarColor : UIColor = UIColor(red: 34.0/255.0, green: 192.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    private var promptHeaderTxtColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    private var promptContentTxtColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    private var promptOutlineColor : UIColor = UIColor.clearColor()
    private var promptTopLineColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    private var promptBottomLineColor : UIColor = UIColor.clearColor()
    private var promptButtonDividerColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    private var promptDismissIconColor : UIColor = UIColor.whiteColor()
    
    //Button panel vars
    private var enableDoubleButtons : Bool = false
    private var mainButtonText : String = "Post"
    private var secondButtonText : String = "Cancel"
    private var mainButtonColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    private var secondButtonColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    
    //Gesture enabling
    private var enablePromptGestures : Bool = true
    
    //Declare the enum for use in the construction of the background switch
    enum TypeOfBackground {
        case LeveledBlurredWithTransparencyView
        case LightBlurredEffect
        case ExtraLightBlurredEffect
        case DarkBlurredEffect
    }
    private var backgroundType = TypeOfBackground.LeveledBlurredWithTransparencyView
    
    //Construct the prompt by overriding the view's drawRect
    override public func drawRect(rect: CGRect) {
        let backgroundImage : UIImage = snapshot(self.superview)
        var effectImage : UIImage!
        var transparencyAndColorImageView : UIImageView!
        
        //Construct the prompt's background
        switch backgroundType {
        case .LeveledBlurredWithTransparencyView:
            if (enableBlurring) {
                effectImage = backgroundImage.applyBlurWithRadius(blurringLevel, tintColor: nil, saturationDeltaFactor: 1.0, maskImage: nil)
                let blurredImageView = UIImageView(image: effectImage)
                self.addSubview(blurredImageView)
            }
            if (enableTransparencyWithColor) {
                transparencyAndColorImageView = UIImageView(frame: self.bounds)
                transparencyAndColorImageView.backgroundColor = colorWithTransparency;
                self.addSubview(transparencyAndColorImageView)
            }
        case .LightBlurredEffect:
            effectImage = backgroundImage.applyLightEffect()
            let lightEffectImageView = UIImageView(image: effectImage)
            self.addSubview(lightEffectImageView)
            
        case .ExtraLightBlurredEffect:
            effectImage = backgroundImage.applyExtraLightEffect()
            let extraLightEffectImageView = UIImageView(image: effectImage)
            self.addSubview(extraLightEffectImageView)
            
        case .DarkBlurredEffect:
            effectImage = backgroundImage.applyDarkEffect()
            let darkEffectImageView = UIImageView(image: effectImage)
            self.addSubview(darkEffectImageView)
        }
        
        //Create the prompt and assign its size and position
        let swiftPrompt = PromptBoxView(master: self)
        swiftPrompt.backgroundColor = UIColor.clearColor()
        swiftPrompt.center = CGPointMake(self.center.x, self.center.y)
        self.addSubview(swiftPrompt)
        
        //Add the button(s) on the bottom of the prompt
        if (enableDoubleButtons == false) {
            let button   = UIButton(type: UIButtonType.System)
            button.frame = CGRectMake(0, promptHeight-52, promptWidth, 41)
            button.setTitleColor(mainButtonColor, forState: .Normal)
            button.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            button.setTitle(mainButtonText, forState: UIControlState.Normal)
            button.tag = 1
            button.addTarget(self, action: #selector(SwiftPromptsView.panelButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    
            swiftPrompt.addSubview(button)
        } else {
            if (promptButtonDividerVisibility) {
                let divider = UIView(frame: CGRectMake(promptWidth/2, promptHeight-47, 0.5, 31))
                divider.backgroundColor = promptButtonDividerColor
                
                swiftPrompt.addSubview(divider)
            }
            
            let button   = UIButton(type: UIButtonType.System)
            button.frame = CGRectMake(promptWidth/2, promptHeight-52, promptWidth/2, 41)
            button.setTitleColor(mainButtonColor, forState: .Normal)
            button.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            button.setTitle(mainButtonText, forState: UIControlState.Normal)
            button.tag = 1
            button.addTarget(self, action: #selector(SwiftPromptsView.panelButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            swiftPrompt.addSubview(button)
            
            let secondButton   = UIButton(type: UIButtonType.System)
            secondButton.frame = CGRectMake(0, promptHeight-52, promptWidth/2, 41)
            secondButton.setTitleColor(secondButtonColor, forState: .Normal)
            secondButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            secondButton.setTitle(secondButtonText, forState: UIControlState.Normal)
            secondButton.tag = 2
            secondButton.addTarget(self, action: #selector(SwiftPromptsView.panelButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            swiftPrompt.addSubview(secondButton)
        }
        
        //Add the top dismiss button if enabled
        if (promptDismissIconVisibility) {
            let dismissButton   = UIButton(type: UIButtonType.System)
            dismissButton.frame = CGRectMake(5, 17, 35, 35)
            dismissButton.addTarget(self, action: #selector(SwiftPromptsView.dismissPrompt), forControlEvents: UIControlEvents.TouchUpInside)
            
            swiftPrompt.addSubview(dismissButton)
        }
        
        //Apply animation effect to present this view
        let applicationLoadViewIn = CATransition()
        applicationLoadViewIn.duration = 0.4
        applicationLoadViewIn.type = kCATransitionReveal
        applicationLoadViewIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.layer.addAnimation(applicationLoadViewIn, forKey: kCATransitionReveal)
    }
    
    func panelButtonAction(sender:UIButton?) {
        switch (sender!.tag) {
        case 1:
            delegate?.clickedOnTheMainButton?()
        case 2:
            delegate?.clickedOnTheSecondButton?()
        default:
            delegate?.promptWasDismissed?()
        }
    }
    
    // MARK: - Helper Functions
    func snapshot(view: UIView!) -> UIImage! {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    public func dismissPrompt() {
        UIView.animateWithDuration(0.6, animations: {
            self.layer.opacity = 0.0
            }, completion: {
                (value: Bool) in
                self.delegate?.promptWasDismissed?()
                self.removeFromSuperview()
        })
    }
    
    // MARK: - API Functions For The Background
    public func setBlurringLevel(level: CGFloat) { blurringLevel = level }
    public func setColorWithTransparency(color: UIColor) { colorWithTransparency = color }
    public func enableBlurringView (enabler : Bool) { enableBlurring = enabler; backgroundType = TypeOfBackground.LeveledBlurredWithTransparencyView; }
    public func enableTransparencyWithColorView (enabler : Bool) { enableTransparencyWithColor = enabler; backgroundType = TypeOfBackground.LeveledBlurredWithTransparencyView; }
    public func enableLightEffectView () { backgroundType = TypeOfBackground.LightBlurredEffect }
    public func enableExtraLightEffectView () { backgroundType = TypeOfBackground.ExtraLightBlurredEffect }
    public func enableDarkEffectView () { backgroundType = TypeOfBackground.DarkBlurredEffect }
    
    // MARK: - API Functions For The Prompt
    public func setPromptHeight (height : CGFloat) { promptHeight = height }
    public func setPromptWidth (width : CGFloat) { promptWidth = width }
    public func setPromptHeader (header : String) { promptHeader = header }
    public func setPromptHeaderTxtSize (headerTxtSize : CGFloat) { promptHeaderTxtSize = headerTxtSize }
    public func setPromptContentText (contentTxt : String) { promptContentText = contentTxt }
    public func setPromptContentTxtSize (contentTxtSize : CGFloat) { promptContentTxtSize = contentTxtSize }
    public func setPromptTopBarVisibility (topBarVisibility : Bool) { promptTopBarVisibility = topBarVisibility }
    public func setPromptBottomBarVisibility (bottomBarVisibility : Bool) { promptBottomBarVisibility = bottomBarVisibility }
    public func setPromptTopLineVisibility (topLineVisibility : Bool) { promptTopLineVisibility = topLineVisibility }
    public func setPromptBottomLineVisibility (bottomLineVisibility : Bool) { promptBottomLineVisibility = bottomLineVisibility }
    public func setPromptOutlineVisibility (outlineVisibility: Bool) { promptOutlineVisibility = outlineVisibility }
    public func setPromptBackgroundColor (backgroundColor : UIColor) { promptBackgroundColor = backgroundColor }
    public func setPromptHeaderBarColor (headerBarColor : UIColor) { promptHeaderBarColor = headerBarColor }
    public func setPromptBottomBarColor (bottomBarColor : UIColor) { promptBottomBarColor = bottomBarColor }
    public func setPromptHeaderTxtColor (headerTxtColor  : UIColor) { promptHeaderTxtColor =  headerTxtColor}
    public func setPromptContentTxtColor (contentTxtColor : UIColor) { promptContentTxtColor = contentTxtColor }
    public func setPromptOutlineColor (outlineColor : UIColor) { promptOutlineColor = outlineColor }
    public func setPromptTopLineColor (topLineColor : UIColor) { promptTopLineColor = topLineColor }
    public func setPromptBottomLineColor (bottomLineColor : UIColor) { promptBottomLineColor = bottomLineColor }
    public func enableDoubleButtonsOnPrompt () { enableDoubleButtons = true }
    public func setMainButtonText (buttonTitle : String) { mainButtonText = buttonTitle }
    public func setSecondButtonText (secondButtonTitle : String) { secondButtonText = secondButtonTitle }
    public func setMainButtonColor (colorForButton : UIColor) { mainButtonColor = colorForButton }
    public func setSecondButtonColor (colorForSecondButton : UIColor) { secondButtonColor = colorForSecondButton }
    public func setPromptButtonDividerColor (dividerColor : UIColor) { promptButtonDividerColor = dividerColor }
    public func setPromptButtonDividerVisibility (dividerVisibility : Bool) { promptButtonDividerVisibility = dividerVisibility }
    public func setPromptDismissIconColor (dismissIconColor : UIColor) { promptDismissIconColor = dismissIconColor }
    public func setPromptDismissIconVisibility (dismissIconVisibility : Bool) { promptDismissIconVisibility = dismissIconVisibility }
    func enableGesturesOnPrompt (gestureEnabler : Bool) { enablePromptGestures = gestureEnabler }
    
    // MARK: - Create The Prompt With A UIView Sublass
    class PromptBoxView: UIView
    {
        //Mater Class
        let masterClass : SwiftPromptsView
        
        //Gesture Recognizer Vars
        var lastLocation:CGPoint = CGPointMake(0, 0)
        
        init(master: SwiftPromptsView)
        {
            //Create a link to the parent class to access its vars and init with the prompts size
            masterClass = master
            let promptSize = CGRect(x: 0, y: 0, width: masterClass.promptWidth, height: masterClass.promptHeight)
            super.init(frame: promptSize)
            
            // Initialize Gesture Recognizer
            if (masterClass.enablePromptGestures) {
                let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(PromptBoxView.detectPan(_:)))
                self.gestureRecognizers = [panRecognizer]
            }
        }

        required init?(coder aDecoder: NSCoder)
        {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func drawRect(rect: CGRect)
        {
            //Call to the SwiftPrompts drawSwiftPrompt func, this handles the drawing of the prompt
            SwiftPrompts.drawSwiftPrompt(frame: self.bounds, backgroundColor: masterClass.promptBackgroundColor, headerBarColor: masterClass.promptHeaderBarColor, bottomBarColor: masterClass.promptBottomBarColor, headerTxtColor: masterClass.promptHeaderTxtColor, contentTxtColor: masterClass.promptContentTxtColor, outlineColor: masterClass.promptOutlineColor, topLineColor: masterClass.promptTopLineColor, bottomLineColor: masterClass.promptBottomLineColor, dismissIconButton: masterClass.promptDismissIconColor, promptText: masterClass.promptContentText, textSize: masterClass.promptContentTxtSize, topBarVisibility: masterClass.promptTopBarVisibility, bottomBarVisibility: masterClass.promptBottomBarVisibility, headerText: masterClass.promptHeader, headerSize: masterClass.promptHeaderTxtSize, topLineVisibility: masterClass.promptTopLineVisibility, bottomLineVisibility: masterClass.promptBottomLineVisibility, outlineVisibility: masterClass.promptOutlineVisibility, dismissIconVisibility: masterClass.promptDismissIconVisibility)
        }
        
        func detectPan(recognizer:UIPanGestureRecognizer)
        {
            if lastLocation==CGPointZero{
                lastLocation = self.center
            }
            let translation  = recognizer.translationInView(self)
            self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
            
            let verticalDistanceFromCenter : CGFloat = fabs(translation.y)
            var shouldDismissPrompt : Bool = false
            
            //Dim the prompt accordingly to the specified radius
            if (verticalDistanceFromCenter < 100.0) {
                let radiusAlphaLevel : CGFloat = 1.0 - verticalDistanceFromCenter/100
                self.alpha = radiusAlphaLevel
                //self.superview!.alpha = radiusAlphaLevel
                shouldDismissPrompt = false
            } else {
                self.alpha = 0.0
                //self.superview!.alpha = 0.0
                shouldDismissPrompt = true
            }
            
            //Handle the end of the pan gesture
            if (recognizer.state == UIGestureRecognizerState.Ended)
            {
                if (shouldDismissPrompt == true) {
                    UIView.animateWithDuration(0.6, animations: {
                        self.layer.opacity = 0.0
                        self.masterClass.layer.opacity = 0.0
                        }, completion: {
                            (value: Bool) in
                            self.masterClass.delegate?.promptWasDismissed?()
                            self.removeFromSuperview()
                            self.masterClass.removeFromSuperview()
                    })
                } else
                {
                    UIView.animateWithDuration(0.3, animations: {
                        self.center = self.masterClass.center
                        self.alpha = 1.0
                        //self.superview!.alpha = 1.0
                    })
                }
            }
        }
        
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
        {
            // Remember original location
            lastLocation = self.center
        }
    }
}
