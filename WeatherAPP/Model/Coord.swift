//
//  Coord.swift
//
//  Created by adika on 9/21/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Coord: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let lon = "lon"
    static let lat = "lat"
  }

  // MARK: Properties
  public var lon: Float?
  public var lat: Float?

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
    lon = json[SerializationKeys.lon].float
    lat = json[SerializationKeys.lat].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = lon { dictionary[SerializationKeys.lon] = value }
    if let value = lat { dictionary[SerializationKeys.lat] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.lon = aDecoder.decodeObject(forKey: SerializationKeys.lon) as? Float
    self.lat = aDecoder.decodeObject(forKey: SerializationKeys.lat) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(lon, forKey: SerializationKeys.lon)
    aCoder.encode(lat, forKey: SerializationKeys.lat)
  }

}
