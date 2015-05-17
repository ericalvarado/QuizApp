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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Add the label to the view
        self.addSubview(answerLabel)
        answerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnswerText(answer:String){
        answerLabel.text = answer
        
        //Set properties for the label
        answerLabel.numberOfLines = 0
        answerLabel.textColor = UIColor.whiteColor()
        answerLabel.textAlignment = NSTextAlignment.Center
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        
        //Set answerlabel constraints
        let leftMarginConstraint = NSLayoutConstraint(item: answerLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 20)
        let rightMarginConstraint = NSLayoutConstraint(item: answerLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -20)
        let topMarginConstraint = NSLayoutConstraint(item: answerLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5)
        let bottomMarginConstraint = NSLayoutConstraint(item: answerLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5)
        
        self.addConstraints([leftMarginConstraint,rightMarginConstraint,topMarginConstraint,bottomMarginConstraint])
        
    }
}
