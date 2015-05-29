//
//  ViewController.swift
//  QuizApp
//
//  Created by Eric Alvarado on 5/10/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    // Properties
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerViewContentView: UIView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var moduleLessonText: UILabel!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var feedBackLabel: UILabel!
    @IBOutlet weak var nextButtonLabel: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var dimView: UIView!

    let quizModel = QuizModel()
    var questions = [Question]()
    var currentQuestion = Question?()
    var answerButtonAnswerArray = [AnswerButtonView]()
    
    // Score Properties
    var score = 0
    
    // Set background color for correct and incorrect answers
    let correctColor = UIColor(red: 43/255, green: 75/255, blue: 26/255, alpha: 0.8)
    let wrongColor = UIColor(red: 133/255, green: 31/255, blue: 23/255, alpha: 0.8)
    let endColor = UIColor(red: 44/255, green: 49/255, blue: 47/255, alpha: 0.8)
    let nextButtonColorCorrect = UIColor(red: 41/255, green: 85/255, blue: 38/255, alpha: 1)
    let nextButtonColorWrong = UIColor(red: 129/255, green: 11/255, blue: 13/255, alpha: 1)
    
    // Constraint Properties
    @IBOutlet weak var verticalSpaceResultViewToView: NSLayoutConstraint!
    
    // User Defaults Properties
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    // Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the questions from the quiz model
        questions = quizModel.getQuestions()
        
        // Initialize the view to hide resultview and dimview
        removeFeedbackViews()
        
        // Check to see if there is at least one question
        if (questions.count > 0){
            // Set the current question to the first question
            currentQuestion = questions[0]
            
            // Load user's state
            loadState()
            
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
            
            // Animate appearance of question and module
            UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                // Set question and module alpha to 1
                self.questionText.alpha = 1
                self.moduleLessonText.alpha = 1
            }, completion: nil)
            
            // Create and display the answer button views
            createAnswerButton()
        }
        
        // Save user's state
        saveState()

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
            var heightConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 99)
            answer.addConstraint(heightConstraint)
            
            var leftConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: answerViewContentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 400)
            var rightConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: answerViewContentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 400)
            var topConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: answerViewContentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: CGFloat(100*index))
            
            answerViewContentView.addConstraints([leftConstraint,rightConstraint,topConstraint])
            
            // Set the answer text for it
            answer.setAnswerText(currentQuestion!.answers[index])
            
            // Set the answer number text
            answer.setAnswerNumber(index+1)
            
            // Add it to the button array
            answerButtonAnswerArray.append(answer)
            
            // Animate the button left and right constraints of the answer buttons
            view.layoutIfNeeded()
            
            // Stagger the delay times
            var delayTime = Double(index) * 0.1
        
            // Animate the answer buttons with a staggered entrance
            UIView.animateWithDuration(1, delay: delayTime, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                leftConstraint.constant = 0
                rightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
        
        // Adjust the height of the scroll view if needed
        // Add to add one to the count otherwise the height is not high enough due to counting error
        var scrollHeightConstraint = NSLayoutConstraint(item: answerViewContentView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: CGFloat(101 * (answerButtonAnswerArray.count+1)))

        answerViewContentView.addConstraint(scrollHeightConstraint)
    }
    
    func answerTapped(gesture:UITapGestureRecognizer){
        
        //Get access to the answer button that was tapped -- this is a forced downcast to an optional
        let answerTapped = gesture.view as! AnswerButtonView?
        
        if let actualAnswerTapped = answerTapped {
            // We got a button, find out which index it was
            let actualTappedIndex = find(answerButtonAnswerArray,actualAnswerTapped)
            
            if let foundTappedIndex = actualTappedIndex {
                
                //Set the button label to Next Question
                nextButtonLabel.setTitle("Next Question", forState: UIControlState.Normal)
                
                // Set result view vertical space real high
                verticalSpaceResultViewToView.constant = 900
                
                // Update the view
                view.layoutIfNeeded()
                
                // Animate alpha
                UIView.animateWithDuration(0.5, animations: {
                    self.verticalSpaceResultViewToView.constant = 30
                    self.view.layoutIfNeeded()
                    
                    // Set Alpha for Feedback Elements to 1
                    self.resultTitleLabel.alpha = 1
                    self.feedBackLabel.alpha = 1
                    self.nextButtonLabel.alpha = 1
                    self.resultView.alpha = 1
                    self.dimView.alpha = 1
                })
                
                // Compare the answer index that was tapped vs the correct index from question
                if foundTappedIndex == currentQuestion?.correctAnswerIndex {
                    resultTitleLabel.text = "Correct"
                    resultView.backgroundColor = correctColor
                    nextButtonLabel.backgroundColor = nextButtonColorCorrect
                    score++
                    
                } else {
                    resultTitleLabel.text = "Incorrect"
                    resultView.backgroundColor = wrongColor
                    nextButtonLabel.backgroundColor = nextButtonColorWrong
                }
                
                // Display feedback
                feedBackLabel.text = currentQuestion?.feedback
                
                // Save user's state
                saveState()
            }
        }
        
    }

    @IBAction func nextQuestion(sender: UIButton) {
        
        // Check to see if the quiz is finished
        if nextButtonLabel.currentTitle == "Restart Quiz" && questions.count > 0 {
            // Set the current question to first question
            currentQuestion = questions[0]
            score = 0
            removeFeedbackViews()
            displayCurrentQuestion()
            clearState()
            return
        }
        
        // Dismiss dim and result views
        dimView.alpha = 0
        resultView.alpha = 0
        
        // Erase the question and module labels
        questionText.text = ""
        moduleLessonText.text = ""
        
        // Remove all the answerbuttonviews
        for button in answerButtonAnswerArray {
            button.removeFromSuperview()
        }
        
        // Flush button array
        answerButtonAnswerArray.removeAll(keepCapacity: false)
        
        
        // Find and check index of current question
        if let currentQuestionIndex = find(questions,currentQuestion!) {
            
            // Found the index
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                // The next question index is within bounds
                
                // Set current question to next question and display thequestion
                currentQuestion = questions[nextQuestionIndex]
                
                removeFeedbackViews()
                
                // Display next question
                displayCurrentQuestion()
                
            } else {
                // The next question index is outside of bounds, therefore quiz is done.
                resultTitleLabel.text = "Quiz Finished"
                resultView.backgroundColor = endColor
                feedBackLabel.text = String(format: "Your score is %d of %d", score,questions.count)
                nextButtonLabel.setTitle("Restart Quiz", forState: UIControlState.Normal)
                nextButtonLabel.backgroundColor = UIColor.darkGrayColor()
                
                displayFeedbackViews()
            }
        }
        
        // Save user's state
        saveState()
    }
    
    func clearState(){
        // Clear user's state - score
        userDefaults.setInteger(0, forKey: "score")
        
        // Clear user's state - current question
        userDefaults.setInteger(0, forKey: "currentquestion")
        
        // Clear user's state - result view
        userDefaults.setBool(false, forKey: "resultview")
        
        // Clear user's state - result title label
        userDefaults.setObject("", forKey: "resulttitleLabel")
        
        // Clear user's state to disk
        userDefaults.synchronize()
    }
    
    func saveState(){
        
        // Save user's state - score
        userDefaults.setInteger(score, forKey: "score")
        
        // Save user's state - current question
        if let indexCurrentQuestion = find(questions,currentQuestion!){
            userDefaults.setInteger(indexCurrentQuestion, forKey: "currentquestion")
        }
        
        // Save user's state - result view
        userDefaults.setBool(resultView.alpha == 1, forKey: "resultviewalpha")
        
        // Save user's state - result title label
        userDefaults.setObject(resultTitleLabel.text, forKey: "resulttitleLabel")
        
        // Save user's state to disk
        userDefaults.synchronize()
        
        
    }
    
    func loadState(){
        
        // Load user's state - score
        let savedScore = userDefaults.integerForKey("score")
        score = savedScore
        
        // Load user's state - current question
        let savedCurrentQuestionIndex = userDefaults.integerForKey("currentquestion")
        
        if savedCurrentQuestionIndex < questions.count {
            currentQuestion = questions[savedCurrentQuestionIndex]
        }
        
        // Load user's state - result view
        let savedResultView = userDefaults.boolForKey("resultviewalpha")
        
        if savedResultView == true {
            displayFeedbackViews()
            
            // Load user's state - result title label - AnyObject that is force casted to optional string
            let savedResultTitleLabel = userDefaults.objectForKey("resulttitleLabel") as! String?
            
            // Optional binding check
            if let actualSavedResultTitleLabel = savedResultTitleLabel {
                resultTitleLabel.text = actualSavedResultTitleLabel
                
                // Set result review color based on loaded result title label
                if resultTitleLabel.text == "Correct" {
                    resultView.backgroundColor = correctColor
                    nextButtonLabel.backgroundColor = nextButtonColorCorrect
                } else {
                    resultView.backgroundColor = wrongColor
                    nextButtonLabel.backgroundColor = nextButtonColorWrong
                }
                
            }
            
        }
    }
    
    func displayFeedbackViews(){
        
        // Reveal result and dim views
        resultView.alpha = 1
        dimView.alpha = 1
        
    }
    
    func removeFeedbackViews(){
        
        // Hide result and dim views
        resultView.alpha = 0
        dimView.alpha = 0
    }
}

