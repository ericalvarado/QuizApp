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

