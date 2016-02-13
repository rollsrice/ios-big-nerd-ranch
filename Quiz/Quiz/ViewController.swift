//
//  ViewController.swift
//  Quiz
//
//  Created by Ryan Zhang on 2016-02-07.
//  Copyright © 2016 Ryan Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    var questionSpace: UILayoutGuide!
    
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?",
                               "What is 7+7?",
                               "What is the capital of Vermont?"]
    
    let answers: [String] = ["Grapes",
                             "14",
                             "Montpelier"]
    
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex = (currentQuestionIndex + 1) % questions.count
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        let questionSpace = UILayoutGuide()
        view.addLayoutGuide(questionSpace)
        questionSpace.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        nextQuestionLabel.centerXAnchor.constraintEqualToAnchor(questionSpace.leadingAnchor).active = true
        currentQuestionLabel.centerXAnchor.constraintEqualToAnchor(questionSpace.trailingAnchor).active = true
        updateOffScreenLabel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        self.nextQuestionLabelCenterXConstraint.constant = 0
        
        UIView.animateWithDuration(0.5,
            delay: 0.5,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 1.0,
            options: [.CurveLinear],
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                swap(&self.currentQuestionLabel,
                     &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint,
                     &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel()
            }
        )
    }
    
    func updateOffScreenLabel() {
        currentQuestionLabelCenterXConstraint.constant = 0
    }
}

