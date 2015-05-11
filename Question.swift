//
//  Question.swift
//  QuizApp
//
//  Created by Eric Alvarado on 5/10/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import UIKit

class Question: NSObject {
    var questionText = ""
    var answers = [String]()
    var correctAnswerIndex = 0
    var module = 0
    var lesson = 0
    var feedback = ""
}
