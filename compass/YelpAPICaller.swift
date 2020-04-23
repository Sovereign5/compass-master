//
//  YelpAPICaller.swift
//  compass
//
//  Created by Christopther Garcia on 4/15/20.
//  Copyright © 2020 Mac Cooper. All rights reserved.
//

import YelpAPI
import CDYelpFusionKit
import BrightFutures

public extension YLPClient {
//  static func authorize(withAppId appId: String, secret: String) -> Future<YLPClient, NSError> {
//    return makeFutureFromCompletionHandler { completionHandler in
//      YLPClient.authorize(withAppId: appId, secret: secret, completionHandler: completionHandler)
//    }
//  }
    
    static func authorize(withAppId appId: String, secret: String) -> Future<YLPClient, NSError> {
      return makeFutureFromCompletionHandler { completionHandler in
        YLPClient.authorize(withAppId: appId, secret: secret, completionHandler: completionHandler)
      }
    }

  func business(withId id: String) -> Future<YLPBusiness, NSError> {
    return makeFutureFromCompletionHandler { completionHandler in
      self.business(withId: id, completionHandler: completionHandler)
    }
  }

  func business(withPhoneNumber phoneNumber: String) -> Future<YLPSearch, NSError> {
    return makeFutureFromCompletionHandler { completionHandler in
      self.business(withPhoneNumber: phoneNumber, completionHandler: completionHandler)
    }
  }

  func search(withQuery query: YLPQuery) -> Future<YLPSearch, NSError> {
    return makeFutureFromCompletionHandler { completionHandler in
      self.search(with: query, completionHandler: completionHandler)
    }
  }

  func reviewsForBusiness(withId businessId: String, locale: String? = nil) -> Future<YLPBusinessReviews, NSError> {
    return makeFutureFromCompletionHandler { completionHandler in
      self.reviewsForBusiness(withId: businessId, locale: locale, completionHandler: completionHandler)
    }
  }
}

private typealias CompletionHandler<T> = (T?, Error?) -> Void

// Provides a completion handler that, when invoked, completes a future
private func makeFutureFromCompletionHandler<T>(_ f: (@escaping CompletionHandler<T>) -> Void) -> Future<T, NSError> {
  let promise = Promise<T, NSError>()
  let completionHandler: CompletionHandler<T> = { value, error in
    if let value = value {
      promise.success(value)
    } else {
      promise.failure(error! as NSError)
    }
  }

  f(completionHandler)
  return promise.future
}
