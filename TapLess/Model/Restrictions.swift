//
//  Restrictions.swift
//  TapLess
//  Created by Liam Sebestyen on 2025-01-16.
import Foundation
struct waitRestriction: Codable {
    var timeSeconds: Int
}
struct mathQuestionRestriction: Codable {
    var question: String
    var answer: Int
}

enum RestrictionType: String, Codable, Identifiable {
    case none
    case wait
    case mathQuestion

    var id: String {self.rawValue}
}

struct RestrictionRule: Codable, Identifiable {
    var id = UUID()
    var RestrictionType: RestrictionType
    var threshold: Int
    
    var waitTime: Int?
    var mathQuestion: String?
    var correctAnswer: Int?
}



//Tests


let rule1 = RestrictionRule(RestrictionType: .wait, threshold: 5, waitTime: 10)
let rule2 = RestrictionRule(RestrictionType: .mathQuestion, threshold: 10, mathQuestion: "5 + 5", correctAnswer: 10)

