//
//  TrieWordNode.swift
//  Prefix-AutoComplete
//
//  Created by William Gill on 2019-07-26.
//  Copyright © 2019 William Gill. All rights reserved.
//

import Foundation

class TrieWordNode<T:CanStringify> {

  let value: Character?
  var children: [TrieWordNode]
  var isWord = false
  var word: T?

  init(value: Character) {
    self.value = value
    self.children = []
  }

  init() {
    self.value = nil
    self.children = []
  }

  init(value: Character, word: T) {
    self.word = word
    self.value = value
    children = []
  }

}
