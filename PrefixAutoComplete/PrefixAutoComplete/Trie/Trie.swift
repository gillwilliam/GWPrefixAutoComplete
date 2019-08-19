//
//  trie.swift
//  Prefix-AutoComplete
//
//  Created by William Gill on 2019-07-26.
//  Copyright © 2019 William Gill. All rights reserved.
//

import Foundation

// trie with level compression
public class Trie<T: Trieable> {

  public typealias TrieableObject = T

  let listOfWords: [TrieableObject]
  let root: TrieWordNode<TrieableObject>

  // early terminate if the search length is longer than the length of the longest word
  var longestLength = -1

  // might need a dictionary for level compression

  //root TrieWordNode

  public init(words: [TrieableObject]) {
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

  public func addWordToTrie(word: TrieableObject) {
    // record the longest length in the search array for early termination
    if word.trieString.count > longestLength {
      longestLength = word.trieString.count
    }

    // follow existing path in trie until there is a difference in the words
    var curTrieWordNode = root

    for letterIndex in 0..<word.trieString.count {
      let letter = Character(String(word.trieString[letterIndex]))

      var foundLetter = false
      for child in curTrieWordNode.children where child.value! == letter { //optimize (flag or do based on length of words array) with a 26 char array?
        curTrieWordNode = child
        foundLetter = true
      }

      if !foundLetter {
        // we create a new TrieWordNode and path diverges here
        let nextTrieWordNode = TrieWordNode<TrieableObject>(value: letter)
        curTrieWordNode.children.append(nextTrieWordNode)
        curTrieWordNode = nextTrieWordNode
      }

      // check if this is the last letter because we need to refer back to the original word for when we perform a search
      // OPTIMIZATION: space by just keeping the ref to the word rather than the actual word
      //               (can keep the index of the word in listOfWords array for simplicity)
      if letterIndex == word.trieString.count - 1 {
        curTrieWordNode.word = word
        curTrieWordNode.isWord = true
      }

      foundLetter = false

    }
  }

  // require a threshold of matched letters? e.g. if no letters are matched don't return anything vs if you're searching banana and give baga.. would be slower
  // cache last few searches? i.e. when the user looks for abc, then looks for abcd the abc TrieWordNode is stored

  public func returnAllPrefixMatches(search: String) -> [TrieableObject] {

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

  func returnAll(currentRoot: TrieWordNode<TrieableObject>) -> [TrieableObject] {
    var matchedWords = [TrieableObject]()

    let trieStack = Stack<TrieWordNode<TrieableObject>>()
    trieStack.push(value: currentRoot)
    while !trieStack.isEmpty() {
      var curTrieWordNode: TrieWordNode<TrieableObject>?
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

public protocol Trieable {
  var trieString: String { get }
}
