//
//  SampleObject.swift
//  PrefixAutoCompleteTests
//
//  Created by William Gill on 2019-08-16.
//  Copyright © 2019 William Gill. All rights reserved.
//

import Foundation
@testable import PrefixAutoComplete


class SampleObject:CanStringify, Equatable {

  let value: Int
  let key: String

  init(value: Int, key: String) {
    self.value = value
    self.key = key
  }

  func stringify() -> String {
    return key
  }

  static func == (lhs: SampleObject, rhs: SampleObject) -> Bool {
    return lhs.key == rhs.key && lhs.value == rhs.value
  }

}
