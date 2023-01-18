//
//  TokenModel.swift
//  PaintTheRoses
//
//  Created by Isiah Marie Ramos Malit on 2023-01-16.
//

import Foundation

enum GameMode: String, CaseIterable {
    case easy, medium, hard
}

struct Game: Codable {
    var mode: Mode?
}

struct Mode: Codable {
    var easy: [Detail]
    var medium: [Detail]
    var hard: [Detail]
}

struct Detail: Codable, Identifiable {
    var attributes: [String]
    var id: Int
}
