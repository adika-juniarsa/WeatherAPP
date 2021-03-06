//
//  Sys.swift
//
//  Created by adika on 9/21/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Sys: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let sunset = "sunset"
    static let sunrise = "sunrise"
    static let message = "message"
    static let country = "country"
  }

  // MARK: Properties
  public var sunset: Int?
  public var sunrise: Int?
  public var message: Float?
  public var country: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    sunset = json[SerializationKeys.sunset].int
    sunrise = json[SerializationKeys.sunrise].int
    message = json[SerializationKeys.message].float
    country = json[SerializationKeys.country].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = sunset { dictionary[SerializationKeys.sunset] = value }
    if let value = sunrise { dictionary[SerializationKeys.sunrise] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }
    if let value = country { dictionary[SerializationKeys.country] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.sunset = aDecoder.decodeObject(forKey: SerializationKeys.sunset) as? Int
    self.sunrise = aDecoder.decodeObject(forKey: SerializationKeys.sunrise) as? Int
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? Float
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(sunset, forKey: SerializationKeys.sunset)
    aCoder.encode(sunrise, forKey: SerializationKeys.sunrise)
    aCoder.encode(message, forKey: SerializationKeys.message)
    aCoder.encode(country, forKey: SerializationKeys.country)
  }

}
