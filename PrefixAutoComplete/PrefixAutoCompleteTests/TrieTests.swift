//
//  TrieTests.swift
//  Prefix-AutoCompleteTests
//
//  Created by William Gill on 2019-07-26.
//  Copyright © 2019 William Gill. All rights reserved.
//

import Foundation

import XCTest
@testable import PrefixAutoComplete

class TrieTests: XCTestCase {

  override func setUp() {

    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    let testOne = ["abc", "bcde", "dabcbdc", "abcde"]
    var testObjectList: [SampleObject] = []
    for (idx, testString) in testOne.enumerated() {
      testObjectList.append(SampleObject(value: idx, key: testString))
    }

    let myTrie = Trie(words: testObjectList)

    XCTAssert(myTrie.returnAllPrefixMatches(search: "ab") == [testObjectList[0], testObjectList[3]], "basic test")
  }

//  func testRandomBruteForceTime() {
//    let myRandomWords = PerformanceTestUtils().generateWords(numWords: 100)
//    let randomSearchTerm = myRandomWords[Int(arc4random_uniform(UInt32(myRandomWords.count-1)))]
//
//    self.measure {
//      PerformanceTestUtils().bruteForceSearch(words: myRandomWords, searchTerm: randomSearchTerm)
//    }
//  }

//  func testRandomTrieTime() {
//    let myRandomWords = PerformanceTestUtils().generateWords(numWords: 100000)
//
//    // print(myRandomWords)
//
//    let randomSearchTerm = myRandomWords[Int(arc4random_uniform(UInt32(myRandomWords.count-1)))]
//    var bruteForceResults = [String]()
//
//    let myTrie = Trie(words: myRandomWords)
//
//    var trieSearchResults = [String]()
//
//    self.measure {
//      trieSearchResults = myTrie.returnAllPrefixMatches(search: randomSearchTerm)
//    }
//
//    bruteForceResults = PerformanceTestUtils().bruteForceSearch(words: myRandomWords, searchTerm: randomSearchTerm)
//
//    // print(trieSearchResults)
//    // print(bruteForceResults)
//    XCTAssert(trieSearchResults == bruteForceResults)
//  }

  func testPerformanceExample() {
    // This is an example of a performance test case.

    // let myRandomWords = PerformanceTestUtils().generateWords(numWords: 100)
    // let searchWord = PerformanceTestUtils().generateWord()

    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
