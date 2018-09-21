//
//  WeatherData.swift
//
//  Created by adika on 9/21/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class WeatherData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let main = "main"
    static let name = "name"
    static let clouds = "clouds"
    static let coord = "coord"
    static let id = "id"
    static let weather = "weather"
    static let dt = "dt"
    static let base = "base"
    static let cod = "cod"
    static let sys = "sys"
    static let wind = "wind"
  }

  // MARK: Properties
  public var main: Main?
  public var name: String?
  public var clouds: Clouds?
  public var coord: Coord?
  public var id: Int?
  public var weather: [Weather]?
  public var dt: Int?
  public var base: String?
  public var cod: Int?
  public var sys: Sys?
  public var wind: Wind?

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
    main = Main(json: json[SerializationKeys.main])
    name = json[SerializationKeys.name].string
    clouds = Clouds(json: json[SerializationKeys.clouds])
    coord = Coord(json: json[SerializationKeys.coord])
    id = json[SerializationKeys.id].int
    if let items = json[SerializationKeys.weather].array { weather = items.map { Weather(json: $0) } }
    dt = json[SerializationKeys.dt].int
    base = json[SerializationKeys.base].string
    cod = json[SerializationKeys.cod].int
    sys = Sys(json: json[SerializationKeys.sys])
    wind = Wind(json: json[SerializationKeys.wind])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = main { dictionary[SerializationKeys.main] = value.dictionaryRepresentation() }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = clouds { dictionary[SerializationKeys.clouds] = value.dictionaryRepresentation() }
    if let value = coord { dictionary[SerializationKeys.coord] = value.dictionaryRepresentation() }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = weather { dictionary[SerializationKeys.weather] = value.map { $0.dictionaryRepresentation() } }
    if let value = dt { dictionary[SerializationKeys.dt] = value }
    if let value = base { dictionary[SerializationKeys.base] = value }
    if let value = cod { dictionary[SerializationKeys.cod] = value }
    if let value = sys { dictionary[SerializationKeys.sys] = value.dictionaryRepresentation() }
    if let value = wind { dictionary[SerializationKeys.wind] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.main = aDecoder.decodeObject(forKey: SerializationKeys.main) as? Main
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.clouds = aDecoder.decodeObject(forKey: SerializationKeys.clouds) as? Clouds
    self.coord = aDecoder.decodeObject(forKey: SerializationKeys.coord) as? Coord
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.weather = aDecoder.decodeObject(forKey: SerializationKeys.weather) as? [Weather]
    self.dt = aDecoder.decodeObject(forKey: SerializationKeys.dt) as? Int
    self.base = aDecoder.decodeObject(forKey: SerializationKeys.base) as? String
    self.cod = aDecoder.decodeObject(forKey: SerializationKeys.cod) as? Int
    self.sys = aDecoder.decodeObject(forKey: SerializationKeys.sys) as? Sys
    self.wind = aDecoder.decodeObject(forKey: SerializationKeys.wind) as? Wind
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(main, forKey: SerializationKeys.main)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(clouds, forKey: SerializationKeys.clouds)
    aCoder.encode(coord, forKey: SerializationKeys.coord)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(weather, forKey: SerializationKeys.weather)
    aCoder.encode(dt, forKey: SerializationKeys.dt)
    aCoder.encode(base, forKey: SerializationKeys.base)
    aCoder.encode(cod, forKey: SerializationKeys.cod)
    aCoder.encode(sys, forKey: SerializationKeys.sys)
    aCoder.encode(wind, forKey: SerializationKeys.wind)
  }

}
