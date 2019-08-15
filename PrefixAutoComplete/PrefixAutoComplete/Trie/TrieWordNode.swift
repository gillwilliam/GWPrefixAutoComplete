//
//  TrieWordNode.swift
//  Prefix-AutoComplete
//
//  Created by William Gill on 2019-07-26.
//  Copyright © 2019 William Gill. All rights reserved.
//

import Foundation

class TrieWordNode {

  let value: Character?
  var children: [TrieWordNode]
  var isWord = false
  var word: String?

  init(value: Character) {
    self.value = value
    self.children = []
  }

  init() {
    self.value = nil
    self.children = []
  }

  init(value: Character, word: String) {
    self.word = word
    self.value = value
    children = []
  }

}
