//
//  ViewController.swift
//  QuizApp
//
//  Created by Eric Alvarado on 5/10/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let quizModel = QuizModel()
    var questions = [Question]()
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerViewContentView: UIView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var moduleLessonText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the questions from the quiz model
        questions = quizModel.getQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

