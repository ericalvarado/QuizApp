//
//  AnswerButton.swift
//  QuizApp
//
//  Created by Eric Alvarado on 5/16/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import UIKit

class AnswerButtonView: UIView {
    
    let answerLabel = UILabel()
    let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the label to the view
        self.addSubview(answerLabel)
        answerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Colorize the button
        self.backgroundColor = UIColor.grayColor()
        self.alpha = 0.5
        
        // Add the number label to the view
        self.addSubview(numberLabel)
        numberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnswerText(answer:String){
        
        // Set the answerLabel text
        answerLabel.text = answer
        
        // Set answerLabel properties
        answerLabel.numberOfLines = 0
        answerLabel.textColor = UIColor.whiteColor()
        answerLabel.textAlignment = NSTextAlignment.Center
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        
        // Set answerLabel constraints
        let leftMarginConstraint = NSLayoutConstraint(item: answerLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 40)
        let rightMarginConstraint = NSLayoutConstraint(item: answerLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -20)
        let topMarginConstraint = NSLayoutConstraint(item: answerLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5)
        let bottomMarginConstraint = NSLayoutConstraint(item: answerLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5)
        
        self.addConstraints([leftMarginConstraint,rightMarginConstraint,topMarginConstraint,bottomMarginConstraint])
        
    }
    
    func setAnswerNumber(answerNumber:Int){
        
        // Set the number of the label
        numberLabel.text = String(answerNumber)
        
        // Set properties for the label
        numberLabel.textColor = UIColor.whiteColor()
        numberLabel.textAlignment = NSTextAlignment.Center
        numberLabel.backgroundColor = UIColor.blackColor()
        numberLabel.alpha = 0.5
        numberLabel.font = UIFont.boldSystemFontOfSize(14)
        
        // Set numberLabel constraints
        let widthConstraint = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        
        numberLabel.addConstraint(widthConstraint)
        
        // Set numberLabel to self constraints
        let leftMarginConstraint = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        let topMarginConstraint = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let bottomMarginConstraint = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        
        self.addConstraints([leftMarginConstraint,topMarginConstraint,bottomMarginConstraint])
        
        
    }
}
