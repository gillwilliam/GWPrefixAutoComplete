//
//  trie.swift
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

enum StackError: Error {
  case StackOutOfBoundsError
}

class Stack<T> {
  var _stack: [T]
  var length: Int

  init() {
    self._stack = []
    self.length = 0
  }

  func push(value: T) {
    self._stack.append(value)
    self.length += 1
  }

  func pop() throws -> T {
    guard length > 0 else {
      throw StackError.StackOutOfBoundsError
    }
    length -= 1
    return _stack.removeLast()
  }

  func isEmpty() -> Bool {
    return length == 0
  }
}

// trie with level compression
class Trie {

  var isStatic: Bool

  // does it make semantic sense to have no words?
  let listOfWords: [String]
  let root: TrieWordNode

  // early terminate if the search length is longer than the length of the longest word
  var longestLength = -1

  // might need a dictionary for level compression

  //root TrieWordNode

  init(words: [String], isStatic:Bool = true) {
    // params: list of words to filter through
    self.isStatic = isStatic
    // dedup the list first or expect them to be unique?
    self.listOfWords = words

    // empty root TrieWordNode
    root = TrieWordNode()

    // construct the trie
    constructTrie()
  }

  // internal construction method for use in the ctor and perhaps if the list of words is updated after construction
  // should we force an explicit call to this or keep in the constuctor? (might be better as an explicit call to implement concurrently)
  func constructTrie() {
    for word in listOfWords {
      addWordToTrie(word: word)
    }
  }

  func addWordToTrie(word: String) {
    // record the longest length in the search array for early termination
    if word.count > longestLength {
      longestLength = word.count
    }

    // follow existing path in trie until there is a difference in the words
    var curTrieWordNode = root

    for letterIndex in 0..<word.count {
      let letter = Character(word[letterIndex])

      var foundLetter = false
      for child in curTrieWordNode.children where child.value! == letter { //optimize (flag or do based on length of words array) with a 26 char array?
        curTrieWordNode = child
        foundLetter = true
      }

      if !foundLetter {
        // we create a new TrieWordNode and path diverges here
        let nextTrieWordNode = TrieWordNode(value: letter)
        curTrieWordNode.children.append(nextTrieWordNode)
        curTrieWordNode = nextTrieWordNode
      }

      // check if this is the last letter because we need to refer back to the original word for when we perform a search
      // OPTIMIZATION: space by just keeping the ref to the word rather than the actual word
      //               (can keep the index of the word in listOfWords array for simplicity)
      if letterIndex == word.count - 1 {
        curTrieWordNode.word = word
        curTrieWordNode.isWord = true
      }

      foundLetter = false

    }
  }

  // require a threshold of matched letters? e.g. if no letters are matched don't return anything vs if you're searching banana and give baga.. would be slower
  // cache last few searches? i.e. when the user looks for abc, then looks for abcd the abc TrieWordNode is stored

  func returnAllPrefixMatches(search: String) -> [String] {

    // early termination if the search length is longer than the longest word in the search dictionary
    guard search.count <= longestLength else {
      return []
    }


    var foundLetter = false
    var curTrieWordNode = root
    //abstract as a closure?
    for letter in search {
      for child in curTrieWordNode.children where child.value == letter {
        curTrieWordNode = child
        foundLetter = true
      }
      guard foundLetter else {
        // no match found (this is where the threshold check would go)
        return []
      }
      foundLetter = false
    }
    // at this point we want to return all of the words from here and below in the tree because they are all prefix matches
    return returnAll(currentRoot: curTrieWordNode)
  }

  // essentially DFS
  func returnAll(currentRoot: TrieWordNode) -> [String] {
    var matchedWords = [String]()

    let trieStack = Stack<TrieWordNode>()
    trieStack.push(value: currentRoot)
    while !trieStack.isEmpty() {
      var curTrieWordNode: TrieWordNode?
      do {
        curTrieWordNode = try trieStack.pop()
      } catch StackError.StackOutOfBoundsError {
        print("stack out of bounds")
      } catch {
        // there are no other errors
        print("unknown error")
      }

      guard let curWordNode = curTrieWordNode else { continue }
      if curWordNode.isWord, let curWord = curWordNode.word {
        matchedWords.append(curWord)
      }
      curWordNode.children.forEach { trieStack.push(value: $0) }
    }

    return matchedWords
  }

}

//From Stack overflow
extension String {

  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }

  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, count) ..< count]
  }

  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }

  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                        upper: min(count, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }

}
