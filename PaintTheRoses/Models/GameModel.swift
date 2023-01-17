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

enum Color {
    case red, pink, yellow, violet
}

enum Shape {
    case spade, heart, clover, diamond
}

enum Combo: String {
    case color
    case shape
}

struct Game: Codable {
    var attributes: Attributes?
    var mode: Mode?
}

struct Attributes: Codable{
    var color: [String]
    var shape: [String]
}

struct Mode: Codable {
    var easy: [Combination]
    var medium: [Combination]
    var hard: [Combination]
}

struct Combination: Codable {
    var side: String
    var top: String
}
