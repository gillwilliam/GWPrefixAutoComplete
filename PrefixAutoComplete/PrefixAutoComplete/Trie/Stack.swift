//
//  Stack.swift
//  Prefix-AutoComplete
//
//  Created by William Gill on 2019-07-26.
//  Copyright © 2019 William Gill. All rights reserved.
//

import Foundation

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
