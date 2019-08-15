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

    let myTrie = Trie(words: testOne)

    XCTAssert(myTrie.returnAllPrefixMatches(search: "ab") == ["abc", "abcde"], "basic test")
  }

  func testRandom() {
    let myRandomWords = PerformanceTestUtils().generateWords(numWords: 1000)

    print(myRandomWords)

    let randomSearchTerm = myRandomWords[Int(arc4random_uniform(UInt32(myRandomWords.count-1)))]
    let bruteForceResults = PerformanceTestUtils().bruteForceSearch(words: myRandomWords, searchTerm: randomSearchTerm)

    let myTrie = Trie(words: myRandomWords)
    let trieSearchResults = myTrie.returnAllPrefixMatches(search: randomSearchTerm)
    print(trieSearchResults)
    print(bruteForceResults)
    XCTAssert(trieSearchResults == bruteForceResults)
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.

    // let myRandomWords = PerformanceTestUtils().generateWords(numWords: 100)
    // let searchWord = PerformanceTestUtils().generateWord()

    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
