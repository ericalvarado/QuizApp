//
//  ViewController.swift
//  QuizApp
//
//  Created by Eric Alvarado on 5/10/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerViewContentView: UIView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var moduleLessonText: UILabel!

    let quizModel = QuizModel()
    var questions = [Question]()
    var currentQuestion = Question?()
    var answerButtonAnswerArray = [AnswerButtonView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the questions from the quiz model
        questions = quizModel.getQuestions()
        
        // Check to see if there is at least one question
        if (questions.count > 0){
            // Set the current question to the first question
            currentQuestion = questions[0]
            
            // Call the display question method
            displayCurrentQuestion()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCurrentQuestion(){
        //Confirm that there is question text
        
        if currentQuestion?.questionText != nil {

            // Update the question text
            questionText.text = currentQuestion?.questionText
            
            // Update the module and lesson text
            moduleLessonText.text = "Module \(currentQuestion!.module) | Lesson \(currentQuestion!.lesson)"
            
            // Create and display the answer button views
            createAnswerButton()
        }
    }
    
    func createAnswerButton(){
        
        for var index=0; index<currentQuestion!.answers.count;index++ {

            // Create an answer button view
            let answer = AnswerButtonView()
            
            // Turn off Autoresizing Mask
            answer.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            // Place it into the content view
            answerViewContentView.addSubview(answer)
            
            // Add a tap gesture recognizer
            let tapGesture = UITapGestureRecognizer(target: self, action: Selector("answerTapped:"))
            answer.addGestureRecognizer(tapGesture)
            
            // Add constraints to the button depending on which one it is
            var heightConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100)
            answer.addConstraint(heightConstraint)
            
            var leftConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: answerViewContentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
            var rightConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: answerViewContentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
            var topConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: answerViewContentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: CGFloat(100*index))
            
            answerViewContentView.addConstraints([leftConstraint,rightConstraint,topConstraint])
            
            // Set the answer text for it
            answer.setAnswerText(currentQuestion!.answers[index])
            
            // Add it to the button array
            answerButtonAnswerArray.append(answer)
            
        }
        
        // Adjust the height of the scroll view if needed
        var scrollHeightConstraint = NSLayoutConstraint(item: answerViewContentView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: CGFloat(101 * answerButtonAnswerArray.count))

        answerViewContentView.addConstraint(scrollHeightConstraint)
    }
    
    func answerTapped(gesture:UITapGestureRecognizer){
        
        //Get access to the answer button that was tapped -- this is a forced downcast to an optional
        let answerTapped = gesture.view as! AnswerButtonView?
        
        if let actualAnswerTapped = answerTapped {
            // We got a button, find out which index it was
            let actualTappedIndex = find(answerButtonAnswerArray,actualAnswerTapped)
            
            if let foundTappedIndex = actualTappedIndex {
                // Compare the answer index that was tapped vs the correct index from question
                if foundTappedIndex == currentQuestion?.correctAnswerIndex {
                    println("Correct")
                } else {
                    println("Incorrect")
                }
                
            }
            
        }
        
    }

}

