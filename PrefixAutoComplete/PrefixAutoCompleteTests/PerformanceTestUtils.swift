//
//  PerformanceTestUtils.swift
//  Prefix-AutoCompleteTests
//
//  Created by William Gill on 2019-07-26.
//  Copyright © 2019 William Gill. All rights reserved.
//

import Foundation

class PerformanceTestUtils {

  func bruteForceSearch(words: [String], searchTerm: String) -> [String] {

    var returnWords = [String]()
    for word in words {
      if word.prefix(searchTerm.count) == searchTerm {
        returnWords.append(word)
      }
    }

    return returnWords
  }

  func generateWords(numWords: Int) -> [String] {

    var randomWords = [String]()
    for _ in 0...numWords {
      randomWords.append(generateWord(wordLength: 6))
    }

    return randomWords
  }

  func generateWord(wordLength: Int) -> String {
    let MAX_LENGTH = UInt32(wordLength)

    let alphabet = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()")

    let length = Int(arc4random_uniform(MAX_LENGTH));

    var word = ""

    for _ in 0...length {
      word += String(alphabet[Int(arc4random_uniform(UInt32(alphabet.count-1)))])
    }

    return word
  }

  
}
