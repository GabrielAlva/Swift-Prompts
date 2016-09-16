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
    @objc optional func clickedOnTheMainButton()
    @objc optional func clickedOnTheSecondButton()
    @objc optional func promptWasDismissed()
}

open class SwiftPromptsView: UIView {
    //Delegate var
    open var delegate : SwiftPromptsProtocol?
    
    //Variables for the background view
    fileprivate var blurringLevel : CGFloat = 5.0
    fileprivate var colorWithTransparency = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.64)
    fileprivate var enableBlurring : Bool = true
    fileprivate var enableTransparencyWithColor : Bool = true
    
    //Variables for the prompt with their default values
    fileprivate var promptHeight : CGFloat = 197.0
    fileprivate var promptWidth : CGFloat = 225.0
    fileprivate var promptHeader : String = "Success"
    fileprivate var promptHeaderTxtSize : CGFloat = 20.0
    fileprivate var promptContentText : String = "You have successfully posted this item to your Facebook wall."
    fileprivate var promptContentTxtSize : CGFloat = 18.0
    fileprivate var promptTopBarVisibility : Bool = false
    fileprivate var promptBottomBarVisibility : Bool = true
    fileprivate var promptTopLineVisibility : Bool = true
    fileprivate var promptBottomLineVisibility : Bool = false
    fileprivate var promptOutlineVisibility : Bool = false
    fileprivate var promptButtonDividerVisibility : Bool = true
    fileprivate var promptDismissIconVisibility : Bool = false
    
    //Colors of the items within the prompt
    fileprivate var promptBackgroundColor : UIColor = UIColor.white
    fileprivate var promptHeaderBarColor : UIColor = UIColor.clear
    fileprivate var promptBottomBarColor : UIColor = UIColor(red: 34.0/255.0, green: 192.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    fileprivate var promptHeaderTxtColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    fileprivate var promptContentTxtColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    fileprivate var promptOutlineColor : UIColor = UIColor.clear
    fileprivate var promptTopLineColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    fileprivate var promptBottomLineColor : UIColor = UIColor.clear
    fileprivate var promptButtonDividerColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    fileprivate var promptDismissIconColor : UIColor = UIColor.white
    
    //Button panel vars
    fileprivate var enableDoubleButtons : Bool = false
    fileprivate var mainButtonText : String = "Post"
    fileprivate var secondButtonText : String = "Cancel"
    fileprivate var mainButtonColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    fileprivate var secondButtonColor : UIColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    
    //Gesture enabling
    fileprivate var enablePromptGestures : Bool = true
    
    //Declare the enum for use in the construction of the background switch
    enum TypeOfBackground {
        case leveledBlurredWithTransparencyView
        case lightBlurredEffect
        case extraLightBlurredEffect
        case darkBlurredEffect
    }
    fileprivate var backgroundType = TypeOfBackground.leveledBlurredWithTransparencyView
    
    //Construct the prompt by overriding the view's drawRect
    override open func draw(_ rect: CGRect) {
        let backgroundImage : UIImage = snapshot(self.superview)
        var effectImage : UIImage!
        var transparencyAndColorImageView : UIImageView!
        
        //Construct the prompt's background
        switch backgroundType {
        case .leveledBlurredWithTransparencyView:
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
        case .lightBlurredEffect:
            effectImage = backgroundImage.applyLightEffect()
            let lightEffectImageView = UIImageView(image: effectImage)
            self.addSubview(lightEffectImageView)
            
        case .extraLightBlurredEffect:
            effectImage = backgroundImage.applyExtraLightEffect()
            let extraLightEffectImageView = UIImageView(image: effectImage)
            self.addSubview(extraLightEffectImageView)
            
        case .darkBlurredEffect:
            effectImage = backgroundImage.applyDarkEffect()
            let darkEffectImageView = UIImageView(image: effectImage)
            self.addSubview(darkEffectImageView)
        }
        
        //Create the prompt and assign its size and position
        let swiftPrompt = PromptBoxView(master: self)
        swiftPrompt.backgroundColor = UIColor.clear
        swiftPrompt.center = CGPoint(x: self.center.x, y: self.center.y)
        self.addSubview(swiftPrompt)
        
        //Add the button(s) on the bottom of the prompt
        if (enableDoubleButtons == false) {
            let button   = UIButton(type: UIButtonType.system)
            button.frame = CGRect(x: 0, y: promptHeight-52, width: promptWidth, height: 41)
            button.setTitleColor(mainButtonColor, for: UIControlState())
            button.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            button.setTitle(mainButtonText, for: UIControlState())
            button.tag = 1
            button.addTarget(self, action: #selector(SwiftPromptsView.panelButtonAction(_:)), for: UIControlEvents.touchUpInside)
    
            swiftPrompt.addSubview(button)
        } else {
            if (promptButtonDividerVisibility) {
                let divider = UIView(frame: CGRect(x: promptWidth/2, y: promptHeight-47, width: 0.5, height: 31))
                divider.backgroundColor = promptButtonDividerColor
                
                swiftPrompt.addSubview(divider)
            }
            
            let button   = UIButton(type: UIButtonType.system)
            button.frame = CGRect(x: promptWidth/2, y: promptHeight-52, width: promptWidth/2, height: 41)
            button.setTitleColor(mainButtonColor, for: UIControlState())
            button.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            button.setTitle(mainButtonText, for: UIControlState())
            button.tag = 1
            button.addTarget(self, action: #selector(SwiftPromptsView.panelButtonAction(_:)), for: UIControlEvents.touchUpInside)
            
            swiftPrompt.addSubview(button)
            
            let secondButton   = UIButton(type: UIButtonType.system)
            secondButton.frame = CGRect(x: 0, y: promptHeight-52, width: promptWidth/2, height: 41)
            secondButton.setTitleColor(secondButtonColor, for: UIControlState())
            secondButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
            secondButton.setTitle(secondButtonText, for: UIControlState())
            secondButton.tag = 2
            secondButton.addTarget(self, action: #selector(SwiftPromptsView.panelButtonAction(_:)), for: UIControlEvents.touchUpInside)
            
            swiftPrompt.addSubview(secondButton)
        }
        
        //Add the top dismiss button if enabled
        if (promptDismissIconVisibility) {
            let dismissButton   = UIButton(type: UIButtonType.system)
            dismissButton.frame = CGRect(x: 5, y: 17, width: 35, height: 35)
            dismissButton.addTarget(self, action: #selector(SwiftPromptsView.dismissPrompt), for: UIControlEvents.touchUpInside)
            
            swiftPrompt.addSubview(dismissButton)
        }
        
        //Apply animation effect to present this view
        let applicationLoadViewIn = CATransition()
        applicationLoadViewIn.duration = 0.4
        applicationLoadViewIn.type = kCATransitionReveal
        applicationLoadViewIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.layer.add(applicationLoadViewIn, forKey: kCATransitionReveal)
    }
    
    func panelButtonAction(_ sender:UIButton?) {
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
    func snapshot(_ view: UIView!) -> UIImage! {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    open func dismissPrompt() {
        UIView.animate(withDuration: 0.6, animations: {
            self.layer.opacity = 0.0
            }, completion: {
                (value: Bool) in
                self.delegate?.promptWasDismissed?()
                self.removeFromSuperview()
        })
    }
    
    // MARK: - API Functions For The Background
    open func setBlurringLevel(_ level: CGFloat) { blurringLevel = level }
    open func setColorWithTransparency(_ color: UIColor) { colorWithTransparency = color }
    open func enableBlurringView (_ enabler : Bool) { enableBlurring = enabler; backgroundType = TypeOfBackground.leveledBlurredWithTransparencyView; }
    open func enableTransparencyWithColorView (_ enabler : Bool) { enableTransparencyWithColor = enabler; backgroundType = TypeOfBackground.leveledBlurredWithTransparencyView; }
    open func enableLightEffectView () { backgroundType = TypeOfBackground.lightBlurredEffect }
    open func enableExtraLightEffectView () { backgroundType = TypeOfBackground.extraLightBlurredEffect }
    open func enableDarkEffectView () { backgroundType = TypeOfBackground.darkBlurredEffect }
    
    // MARK: - API Functions For The Prompt
    open func setPromptHeight (_ height : CGFloat) { promptHeight = height }
    open func setPromptWidth (_ width : CGFloat) { promptWidth = width }
    open func setPromptHeader (_ header : String) { promptHeader = header }
    open func setPromptHeaderTxtSize (_ headerTxtSize : CGFloat) { promptHeaderTxtSize = headerTxtSize }
    open func setPromptContentText (_ contentTxt : String) { promptContentText = contentTxt }
    open func setPromptContentTxtSize (_ contentTxtSize : CGFloat) { promptContentTxtSize = contentTxtSize }
    open func setPromptTopBarVisibility (_ topBarVisibility : Bool) { promptTopBarVisibility = topBarVisibility }
    open func setPromptBottomBarVisibility (_ bottomBarVisibility : Bool) { promptBottomBarVisibility = bottomBarVisibility }
    open func setPromptTopLineVisibility (_ topLineVisibility : Bool) { promptTopLineVisibility = topLineVisibility }
    open func setPromptBottomLineVisibility (_ bottomLineVisibility : Bool) { promptBottomLineVisibility = bottomLineVisibility }
    open func setPromptOutlineVisibility (_ outlineVisibility: Bool) { promptOutlineVisibility = outlineVisibility }
    open func setPromptBackgroundColor (_ backgroundColor : UIColor) { promptBackgroundColor = backgroundColor }
    open func setPromptHeaderBarColor (_ headerBarColor : UIColor) { promptHeaderBarColor = headerBarColor }
    open func setPromptBottomBarColor (_ bottomBarColor : UIColor) { promptBottomBarColor = bottomBarColor }
    open func setPromptHeaderTxtColor (_ headerTxtColor  : UIColor) { promptHeaderTxtColor =  headerTxtColor}
    open func setPromptContentTxtColor (_ contentTxtColor : UIColor) { promptContentTxtColor = contentTxtColor }
    open func setPromptOutlineColor (_ outlineColor : UIColor) { promptOutlineColor = outlineColor }
    open func setPromptTopLineColor (_ topLineColor : UIColor) { promptTopLineColor = topLineColor }
    open func setPromptBottomLineColor (_ bottomLineColor : UIColor) { promptBottomLineColor = bottomLineColor }
    open func enableDoubleButtonsOnPrompt () { enableDoubleButtons = true }
    open func setMainButtonText (_ buttonTitle : String) { mainButtonText = buttonTitle }
    open func setSecondButtonText (_ secondButtonTitle : String) { secondButtonText = secondButtonTitle }
    open func setMainButtonColor (_ colorForButton : UIColor) { mainButtonColor = colorForButton }
    open func setSecondButtonColor (_ colorForSecondButton : UIColor) { secondButtonColor = colorForSecondButton }
    open func setPromptButtonDividerColor (_ dividerColor : UIColor) { promptButtonDividerColor = dividerColor }
    open func setPromptButtonDividerVisibility (_ dividerVisibility : Bool) { promptButtonDividerVisibility = dividerVisibility }
    open func setPromptDismissIconColor (_ dismissIconColor : UIColor) { promptDismissIconColor = dismissIconColor }
    open func setPromptDismissIconVisibility (_ dismissIconVisibility : Bool) { promptDismissIconVisibility = dismissIconVisibility }
    func enableGesturesOnPrompt (_ gestureEnabler : Bool) { enablePromptGestures = gestureEnabler }
    
    // MARK: - Create The Prompt With A UIView Sublass
    class PromptBoxView: UIView
    {
        //Mater Class
        let masterClass : SwiftPromptsView
        
        //Gesture Recognizer Vars
        var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
        
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
        
        override func draw(_ rect: CGRect)
        {
            //Call to the SwiftPrompts drawSwiftPrompt func, this handles the drawing of the prompt
            SwiftPrompts.drawSwiftPrompt(frame: self.bounds, backgroundColor: masterClass.promptBackgroundColor, headerBarColor: masterClass.promptHeaderBarColor, bottomBarColor: masterClass.promptBottomBarColor, headerTxtColor: masterClass.promptHeaderTxtColor, contentTxtColor: masterClass.promptContentTxtColor, outlineColor: masterClass.promptOutlineColor, topLineColor: masterClass.promptTopLineColor, bottomLineColor: masterClass.promptBottomLineColor, dismissIconButton: masterClass.promptDismissIconColor, promptText: masterClass.promptContentText, textSize: masterClass.promptContentTxtSize, topBarVisibility: masterClass.promptTopBarVisibility, bottomBarVisibility: masterClass.promptBottomBarVisibility, headerText: masterClass.promptHeader, headerSize: masterClass.promptHeaderTxtSize, topLineVisibility: masterClass.promptTopLineVisibility, bottomLineVisibility: masterClass.promptBottomLineVisibility, outlineVisibility: masterClass.promptOutlineVisibility, dismissIconVisibility: masterClass.promptDismissIconVisibility)
        }
        
        func detectPan(_ recognizer:UIPanGestureRecognizer)
        {
            if lastLocation==CGPoint.zero{
                lastLocation = self.center
            }
            let translation  = recognizer.translation(in: self)
            self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
            
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
            if (recognizer.state == UIGestureRecognizerState.ended)
            {
                if (shouldDismissPrompt == true) {
                    UIView.animate(withDuration: 0.6, animations: {
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
                    UIView.animate(withDuration: 0.3, animations: {
                        self.center = self.masterClass.center
                        self.alpha = 1.0
                        //self.superview!.alpha = 1.0
                    })
                }
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            // Remember original location
            lastLocation = self.center
        }
    }
}
