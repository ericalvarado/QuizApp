//
//  QuizModel.swift
//  QuizApp
//
//  Created by Eric Alvarado on 5/10/15.
//  Copyright (c) 2015 Eric Alvarado. All rights reserved.
//

import UIKit

class QuizModel: NSObject {
    func getQuestions() -> [Question]{
        //Questions to return
        var questions = [Question]()
        
        //Get JSON file
        //var jsonObjects = getLocalJsonFile()
        var jsonObjects = getRemoteJsonFile()
        
        //TODO: Parse JSON file
        for var index = 0; index < jsonObjects.count; index++ {
            
            //Current JSON Dictionary
            let jsonDictionary = jsonObjects[index]
            
            //Create a Question Object
            var q = Question()
            
            //Assign value to key value pair; not the objects are "AnyObject" and need to be forced downcasted with as!
            q.questionText = jsonDictionary["question"] as! String
            q.answers = jsonDictionary["answers"] as! [String]
            q.correctAnswerIndex = jsonDictionary["correctIndex"] as! Int
            q.module = jsonDictionary["module"] as! Int
            q.lesson = jsonDictionary["lesson"] as! Int
            q.feedback = jsonDictionary["feedback"] as! String

            //Appened Question object into [Question]
            questions.append(q)
        }
        
        //Return list of question objects
        return questions
    }
    
    func getRemoteJsonFile()->[NSDictionary]{
        // This is using Synchronous Downloading and could be prohibitive if data set is large!
        
        // Create a new URL
        let remoteURL = NSURL(string: "http://codewithchris.com/code/QuestionData.json")
        
        // Optional bind
        
        if let remoteURL = remoteURL {
            
            // Try to download data
            let jsonData = NSData(contentsOfURL: remoteURL)
            
            //Using check if nil as an alternative to serialize the data
            if jsonData != nil {
                
                //Serialize the data
                let arrayOfDictionaries = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! [NSDictionary]?
                
                if let actualArrayOfDictionaries = arrayOfDictionaries {
                    return actualArrayOfDictionaries
                }
            }
            
        }
        
        //Return empty array of dictionary if no data
        return [NSDictionary]()
    }
    
    func getLocalJsonFile()->[NSDictionary]{
        
        //Get an NSURL object point to the json file in our app bundle
        let appBundlePath = NSBundle.mainBundle().pathForResource("questions", ofType: "json")
        
        //Using optional binding to check if path exists
        if let actualAppBundlePath = appBundlePath{
            
            //Need to get URL to file
            let urlPath = NSURL(fileURLWithPath: actualAppBundlePath)
            
            //Using optional binding to check if URL exists
            if let actualURLPath = urlPath {
                
                //Net to get NSData from file
                let jsonData = NSData(contentsOfURL: actualURLPath)
                
                //Using check if nil as an alternative to serialize the data
                if jsonData != nil {
                    
                    //Serialize the data
                    let arrayOfDictionaries = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! [NSDictionary]?
                    
                    if let actualArrayOfDictionaries = arrayOfDictionaries {
                        return actualArrayOfDictionaries
                    }
                }
            }
        }
        return [NSDictionary]()
    }
}
