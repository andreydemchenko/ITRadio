// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FavoritesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Favorites {
      favorites {
        __typename
        favorite
        rating
        track {
          __typename
          _id
          album
          appleMusicId
          artist
          cover {
            __typename
            big
            small
          }
          title
          track
          spotifyID
          yandexMusicId
        }
      }
    }
    """

  public let operationName: String = "Favorites"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("favorites", type: .list(.object(Favorite.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(favorites: [Favorite?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "favorites": favorites.flatMap { (value: [Favorite?]) -> [ResultMap?] in value.map { (value: Favorite?) -> ResultMap? in value.flatMap { (value: Favorite) -> ResultMap in value.resultMap } } }])
    }

    public var favorites: [Favorite?]? {
      get {
        return (resultMap["favorites"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Favorite?] in value.map { (value: ResultMap?) -> Favorite? in value.flatMap { (value: ResultMap) -> Favorite in Favorite(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Favorite?]) -> [ResultMap?] in value.map { (value: Favorite?) -> ResultMap? in value.flatMap { (value: Favorite) -> ResultMap in value.resultMap } } }, forKey: "favorites")
      }
    }

    public struct Favorite: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Favorite"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("favorite", type: .scalar(Bool.self)),
          GraphQLField("rating", type: .scalar(Bool.self)),
          GraphQLField("track", type: .object(Track.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(favorite: Bool? = nil, rating: Bool? = nil, track: Track? = nil) {
        self.init(unsafeResultMap: ["__typename": "Favorite", "favorite": favorite, "rating": rating, "track": track.flatMap { (value: Track) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var favorite: Bool? {
        get {
          return resultMap["favorite"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "favorite")
        }
      }

      public var rating: Bool? {
        get {
          return resultMap["rating"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "rating")
        }
      }

      public var track: Track? {
        get {
          return (resultMap["track"] as? ResultMap).flatMap { Track(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "track")
        }
      }

      public struct Track: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ShortTrack"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("album", type: .scalar(String.self)),
            GraphQLField("appleMusicId", type: .scalar(Int.self)),
            GraphQLField("artist", type: .scalar(String.self)),
            GraphQLField("cover", type: .object(Cover.selections)),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("track", type: .scalar(String.self)),
            GraphQLField("spotifyID", type: .scalar(String.self)),
            GraphQLField("yandexMusicId", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID, album: String? = nil, appleMusicId: Int? = nil, artist: String? = nil, cover: Cover? = nil, title: String? = nil, track: String? = nil, spotifyId: String? = nil, yandexMusicId: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShortTrack", "_id": _id, "album": album, "appleMusicId": appleMusicId, "artist": artist, "cover": cover.flatMap { (value: Cover) -> ResultMap in value.resultMap }, "title": title, "track": track, "spotifyID": spotifyId, "yandexMusicId": yandexMusicId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var _id: GraphQLID {
          get {
            return resultMap["_id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var album: String? {
          get {
            return resultMap["album"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "album")
          }
        }

        public var appleMusicId: Int? {
          get {
            return resultMap["appleMusicId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "appleMusicId")
          }
        }

        public var artist: String? {
          get {
            return resultMap["artist"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "artist")
          }
        }

        public var cover: Cover? {
          get {
            return (resultMap["cover"] as? ResultMap).flatMap { Cover(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "cover")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var track: String? {
          get {
            return resultMap["track"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "track")
          }
        }

        public var spotifyId: String? {
          get {
            return resultMap["spotifyID"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "spotifyID")
          }
        }

        public var yandexMusicId: Int? {
          get {
            return resultMap["yandexMusicId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "yandexMusicId")
          }
        }

        public struct Cover: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Cover"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("big", type: .scalar(String.self)),
              GraphQLField("small", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(big: String? = nil, small: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Cover", "big": big, "small": small])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var big: String? {
            get {
              return resultMap["big"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "big")
            }
          }

          public var small: String? {
            get {
              return resultMap["small"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "small")
            }
          }
        }
      }
    }
  }
}

public final class FeedbackMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Feedback($text: String!) {
      feedback(text: $text)
    }
    """

  public let operationName: String = "Feedback"

  public var text: String

  public init(text: String) {
    self.text = text
  }

  public var variables: GraphQLMap? {
    return ["text": text]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("feedback", arguments: ["text": GraphQLVariable("text")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(feedback: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "feedback": feedback])
    }

    public var feedback: String? {
      get {
        return resultMap["feedback"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "feedback")
      }
    }
  }
}

public final class GetTrackDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getTrackDetails($title: String!) {
      track_v2(title: $title) {
        __typename
        _id
        album
        appleMusic {
          __typename
          albumId
          trackId
          url
        }
        artist
        cover {
          __typename
          big
          small
        }
        genre
        rating {
          __typename
          dislikes
          likes
        }
        release
        spotify {
          __typename
          trackId
          url
        }
        title
        track
        userRating
        wikipedia
        yandexMusic {
          __typename
          albumId
          trackId
          url
        }
      }
    }
    """

  public let operationName: String = "getTrackDetails"

  public var title: String

  public init(title: String) {
    self.title = title
  }

  public var variables: GraphQLMap? {
    return ["title": title]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("track_v2", arguments: ["title": GraphQLVariable("title")], type: .object(TrackV2.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(trackV2: TrackV2? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "track_v2": trackV2.flatMap { (value: TrackV2) -> ResultMap in value.resultMap }])
    }

    public var trackV2: TrackV2? {
      get {
        return (resultMap["track_v2"] as? ResultMap).flatMap { TrackV2(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "track_v2")
      }
    }

    public struct TrackV2: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Track_v2"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("album", type: .scalar(String.self)),
          GraphQLField("appleMusic", type: .object(AppleMusic.selections)),
          GraphQLField("artist", type: .scalar(String.self)),
          GraphQLField("cover", type: .object(Cover.selections)),
          GraphQLField("genre", type: .scalar(String.self)),
          GraphQLField("rating", type: .object(Rating.selections)),
          GraphQLField("release", type: .scalar(String.self)),
          GraphQLField("spotify", type: .object(Spotify.selections)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("track", type: .scalar(String.self)),
          GraphQLField("userRating", type: .scalar(Bool.self)),
          GraphQLField("wikipedia", type: .scalar(String.self)),
          GraphQLField("yandexMusic", type: .object(YandexMusic.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID, album: String? = nil, appleMusic: AppleMusic? = nil, artist: String? = nil, cover: Cover? = nil, genre: String? = nil, rating: Rating? = nil, release: String? = nil, spotify: Spotify? = nil, title: String? = nil, track: String? = nil, userRating: Bool? = nil, wikipedia: String? = nil, yandexMusic: YandexMusic? = nil) {
        self.init(unsafeResultMap: ["__typename": "Track_v2", "_id": _id, "album": album, "appleMusic": appleMusic.flatMap { (value: AppleMusic) -> ResultMap in value.resultMap }, "artist": artist, "cover": cover.flatMap { (value: Cover) -> ResultMap in value.resultMap }, "genre": genre, "rating": rating.flatMap { (value: Rating) -> ResultMap in value.resultMap }, "release": release, "spotify": spotify.flatMap { (value: Spotify) -> ResultMap in value.resultMap }, "title": title, "track": track, "userRating": userRating, "wikipedia": wikipedia, "yandexMusic": yandexMusic.flatMap { (value: YandexMusic) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var _id: GraphQLID {
        get {
          return resultMap["_id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var album: String? {
        get {
          return resultMap["album"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "album")
        }
      }

      public var appleMusic: AppleMusic? {
        get {
          return (resultMap["appleMusic"] as? ResultMap).flatMap { AppleMusic(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "appleMusic")
        }
      }

      public var artist: String? {
        get {
          return resultMap["artist"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "artist")
        }
      }

      public var cover: Cover? {
        get {
          return (resultMap["cover"] as? ResultMap).flatMap { Cover(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "cover")
        }
      }

      public var genre: String? {
        get {
          return resultMap["genre"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "genre")
        }
      }

      public var rating: Rating? {
        get {
          return (resultMap["rating"] as? ResultMap).flatMap { Rating(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "rating")
        }
      }

      public var release: String? {
        get {
          return resultMap["release"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "release")
        }
      }

      public var spotify: Spotify? {
        get {
          return (resultMap["spotify"] as? ResultMap).flatMap { Spotify(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "spotify")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var track: String? {
        get {
          return resultMap["track"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "track")
        }
      }

      public var userRating: Bool? {
        get {
          return resultMap["userRating"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "userRating")
        }
      }

      public var wikipedia: String? {
        get {
          return resultMap["wikipedia"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "wikipedia")
        }
      }

      public var yandexMusic: YandexMusic? {
        get {
          return (resultMap["yandexMusic"] as? ResultMap).flatMap { YandexMusic(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "yandexMusic")
        }
      }

      public struct AppleMusic: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["AppleMusic_v2"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("albumId", type: .scalar(Int.self)),
            GraphQLField("trackId", type: .scalar(Int.self)),
            GraphQLField("url", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(albumId: Int? = nil, trackId: Int? = nil, url: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "AppleMusic_v2", "albumId": albumId, "trackId": trackId, "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var albumId: Int? {
          get {
            return resultMap["albumId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "albumId")
          }
        }

        public var trackId: Int? {
          get {
            return resultMap["trackId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "trackId")
          }
        }

        public var url: String? {
          get {
            return resultMap["url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }
      }

      public struct Cover: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Cover"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("big", type: .scalar(String.self)),
            GraphQLField("small", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(big: String? = nil, small: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Cover", "big": big, "small": small])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var big: String? {
          get {
            return resultMap["big"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "big")
          }
        }

        public var small: String? {
          get {
            return resultMap["small"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "small")
          }
        }
      }

      public struct Rating: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["TrackRating_v2"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("dislikes", type: .scalar(Int.self)),
            GraphQLField("likes", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(dislikes: Int? = nil, likes: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "TrackRating_v2", "dislikes": dislikes, "likes": likes])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var dislikes: Int? {
          get {
            return resultMap["dislikes"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "dislikes")
          }
        }

        public var likes: Int? {
          get {
            return resultMap["likes"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "likes")
          }
        }
      }

      public struct Spotify: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Spotify"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("trackId", type: .scalar(String.self)),
            GraphQLField("url", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(trackId: String? = nil, url: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Spotify", "trackId": trackId, "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var trackId: String? {
          get {
            return resultMap["trackId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "trackId")
          }
        }

        public var url: String? {
          get {
            return resultMap["url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }
      }

      public struct YandexMusic: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["YandexMusic"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("albumId", type: .scalar(Int.self)),
            GraphQLField("trackId", type: .scalar(Int.self)),
            GraphQLField("url", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(albumId: Int? = nil, trackId: Int? = nil, url: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "YandexMusic", "albumId": albumId, "trackId": trackId, "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var albumId: Int? {
          get {
            return resultMap["albumId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "albumId")
          }
        }

        public var trackId: Int? {
          get {
            return resultMap["trackId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "trackId")
          }
        }

        public var url: String? {
          get {
            return resultMap["url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }
      }
    }
  }
}

public final class LoginV2Mutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Login_v2($email: String!, $password: String!) {
      login_v2(email: $email, password: $password)
    }
    """

  public let operationName: String = "Login_v2"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("login_v2", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(loginV2: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login_v2": loginV2])
    }

    public var loginV2: String? {
      get {
        return resultMap["login_v2"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login_v2")
      }
    }
  }
}

public final class LogoutMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Logout {
      logout
    }
    """

  public let operationName: String = "Logout"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("logout", type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(logout: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "logout": logout])
    }

    public var logout: String? {
      get {
        return resultMap["logout"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "logout")
      }
    }
  }
}

public final class ProfileV2Query: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Profile_v2 {
      profile_v2 {
        __typename
        _id
        birthday
        email
        gender
        username
      }
    }
    """

  public let operationName: String = "Profile_v2"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("profile_v2", type: .object(ProfileV2.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(profileV2: ProfileV2? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "profile_v2": profileV2.flatMap { (value: ProfileV2) -> ResultMap in value.resultMap }])
    }

    public var profileV2: ProfileV2? {
      get {
        return (resultMap["profile_v2"] as? ResultMap).flatMap { ProfileV2(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "profile_v2")
      }
    }

    public struct ProfileV2: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User_v2"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("birthday", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("gender", type: .scalar(String.self)),
          GraphQLField("username", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID, birthday: String? = nil, email: String? = nil, gender: String? = nil, username: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User_v2", "_id": _id, "birthday": birthday, "email": email, "gender": gender, "username": username])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var _id: GraphQLID {
        get {
          return resultMap["_id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var birthday: String? {
        get {
          return resultMap["birthday"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "birthday")
        }
      }

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var gender: String? {
        get {
          return resultMap["gender"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "gender")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }
    }
  }
}

public final class RateV2Mutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Rate_v2($trackId: ID!, $rating: Boolean) {
      rate_v2(trackId: $trackId, rating: $rating) {
        __typename
        dislikes
        likes
      }
    }
    """

  public let operationName: String = "Rate_v2"

  public var trackId: GraphQLID
  public var rating: Bool?

  public init(trackId: GraphQLID, rating: Bool? = nil) {
    self.trackId = trackId
    self.rating = rating
  }

  public var variables: GraphQLMap? {
    return ["trackId": trackId, "rating": rating]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("rate_v2", arguments: ["trackId": GraphQLVariable("trackId"), "rating": GraphQLVariable("rating")], type: .object(RateV2.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(rateV2: RateV2? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "rate_v2": rateV2.flatMap { (value: RateV2) -> ResultMap in value.resultMap }])
    }

    public var rateV2: RateV2? {
      get {
        return (resultMap["rate_v2"] as? ResultMap).flatMap { RateV2(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "rate_v2")
      }
    }

    public struct RateV2: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["TrackRating_v2"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("dislikes", type: .scalar(Int.self)),
          GraphQLField("likes", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(dislikes: Int? = nil, likes: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "TrackRating_v2", "dislikes": dislikes, "likes": likes])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var dislikes: Int? {
        get {
          return resultMap["dislikes"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "dislikes")
        }
      }

      public var likes: Int? {
        get {
          return resultMap["likes"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "likes")
        }
      }
    }
  }
}

public final class RatingsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Ratings {
      ratings {
        __typename
        rating
        track {
          __typename
          _id
          title
          track
          artist
          cover {
            __typename
            big
            small
          }
          album
          release
          rating {
            __typename
            likes
            dislikes
          }
          genre
          wikipedia
          userRating
          spotify {
            __typename
            trackId
            url
          }
          appleMusic {
            __typename
            trackId
            albumId
            url
          }
          yandexMusic {
            __typename
            trackId
            albumId
            url
          }
        }
      }
    }
    """

  public let operationName: String = "Ratings"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("ratings", type: .list(.object(Rating.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(ratings: [Rating?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "ratings": ratings.flatMap { (value: [Rating?]) -> [ResultMap?] in value.map { (value: Rating?) -> ResultMap? in value.flatMap { (value: Rating) -> ResultMap in value.resultMap } } }])
    }

    public var ratings: [Rating?]? {
      get {
        return (resultMap["ratings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Rating?] in value.map { (value: ResultMap?) -> Rating? in value.flatMap { (value: ResultMap) -> Rating in Rating(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Rating?]) -> [ResultMap?] in value.map { (value: Rating?) -> ResultMap? in value.flatMap { (value: Rating) -> ResultMap in value.resultMap } } }, forKey: "ratings")
      }
    }

    public struct Rating: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserTrackRating"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("rating", type: .scalar(Bool.self)),
          GraphQLField("track", type: .object(Track.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(rating: Bool? = nil, track: Track? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserTrackRating", "rating": rating, "track": track.flatMap { (value: Track) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var rating: Bool? {
        get {
          return resultMap["rating"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "rating")
        }
      }

      public var track: Track? {
        get {
          return (resultMap["track"] as? ResultMap).flatMap { Track(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "track")
        }
      }

      public struct Track: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Track_v2"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("track", type: .scalar(String.self)),
            GraphQLField("artist", type: .scalar(String.self)),
            GraphQLField("cover", type: .object(Cover.selections)),
            GraphQLField("album", type: .scalar(String.self)),
            GraphQLField("release", type: .scalar(String.self)),
            GraphQLField("rating", type: .object(Rating.selections)),
            GraphQLField("genre", type: .scalar(String.self)),
            GraphQLField("wikipedia", type: .scalar(String.self)),
            GraphQLField("userRating", type: .scalar(Bool.self)),
            GraphQLField("spotify", type: .object(Spotify.selections)),
            GraphQLField("appleMusic", type: .object(AppleMusic.selections)),
            GraphQLField("yandexMusic", type: .object(YandexMusic.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID, title: String? = nil, track: String? = nil, artist: String? = nil, cover: Cover? = nil, album: String? = nil, release: String? = nil, rating: Rating? = nil, genre: String? = nil, wikipedia: String? = nil, userRating: Bool? = nil, spotify: Spotify? = nil, appleMusic: AppleMusic? = nil, yandexMusic: YandexMusic? = nil) {
          self.init(unsafeResultMap: ["__typename": "Track_v2", "_id": _id, "title": title, "track": track, "artist": artist, "cover": cover.flatMap { (value: Cover) -> ResultMap in value.resultMap }, "album": album, "release": release, "rating": rating.flatMap { (value: Rating) -> ResultMap in value.resultMap }, "genre": genre, "wikipedia": wikipedia, "userRating": userRating, "spotify": spotify.flatMap { (value: Spotify) -> ResultMap in value.resultMap }, "appleMusic": appleMusic.flatMap { (value: AppleMusic) -> ResultMap in value.resultMap }, "yandexMusic": yandexMusic.flatMap { (value: YandexMusic) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var _id: GraphQLID {
          get {
            return resultMap["_id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var track: String? {
          get {
            return resultMap["track"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "track")
          }
        }

        public var artist: String? {
          get {
            return resultMap["artist"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "artist")
          }
        }

        public var cover: Cover? {
          get {
            return (resultMap["cover"] as? ResultMap).flatMap { Cover(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "cover")
          }
        }

        public var album: String? {
          get {
            return resultMap["album"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "album")
          }
        }

        public var release: String? {
          get {
            return resultMap["release"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "release")
          }
        }

        public var rating: Rating? {
          get {
            return (resultMap["rating"] as? ResultMap).flatMap { Rating(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "rating")
          }
        }

        public var genre: String? {
          get {
            return resultMap["genre"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "genre")
          }
        }

        public var wikipedia: String? {
          get {
            return resultMap["wikipedia"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "wikipedia")
          }
        }

        public var userRating: Bool? {
          get {
            return resultMap["userRating"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "userRating")
          }
        }

        public var spotify: Spotify? {
          get {
            return (resultMap["spotify"] as? ResultMap).flatMap { Spotify(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "spotify")
          }
        }

        public var appleMusic: AppleMusic? {
          get {
            return (resultMap["appleMusic"] as? ResultMap).flatMap { AppleMusic(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "appleMusic")
          }
        }

        public var yandexMusic: YandexMusic? {
          get {
            return (resultMap["yandexMusic"] as? ResultMap).flatMap { YandexMusic(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "yandexMusic")
          }
        }

        public struct Cover: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Cover"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("big", type: .scalar(String.self)),
              GraphQLField("small", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(big: String? = nil, small: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Cover", "big": big, "small": small])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var big: String? {
            get {
              return resultMap["big"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "big")
            }
          }

          public var small: String? {
            get {
              return resultMap["small"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "small")
            }
          }
        }

        public struct Rating: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["TrackRating_v2"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("likes", type: .scalar(Int.self)),
              GraphQLField("dislikes", type: .scalar(Int.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(likes: Int? = nil, dislikes: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "TrackRating_v2", "likes": likes, "dislikes": dislikes])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var likes: Int? {
            get {
              return resultMap["likes"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "likes")
            }
          }

          public var dislikes: Int? {
            get {
              return resultMap["dislikes"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "dislikes")
            }
          }
        }

        public struct Spotify: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Spotify"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("trackId", type: .scalar(String.self)),
              GraphQLField("url", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(trackId: String? = nil, url: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Spotify", "trackId": trackId, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var trackId: String? {
            get {
              return resultMap["trackId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "trackId")
            }
          }

          public var url: String? {
            get {
              return resultMap["url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }

        public struct AppleMusic: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["AppleMusic_v2"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("trackId", type: .scalar(Int.self)),
              GraphQLField("albumId", type: .scalar(Int.self)),
              GraphQLField("url", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(trackId: Int? = nil, albumId: Int? = nil, url: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "AppleMusic_v2", "trackId": trackId, "albumId": albumId, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var trackId: Int? {
            get {
              return resultMap["trackId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "trackId")
            }
          }

          public var albumId: Int? {
            get {
              return resultMap["albumId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "albumId")
            }
          }

          public var url: String? {
            get {
              return resultMap["url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }

        public struct YandexMusic: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["YandexMusic"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("trackId", type: .scalar(Int.self)),
              GraphQLField("albumId", type: .scalar(Int.self)),
              GraphQLField("url", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(trackId: Int? = nil, albumId: Int? = nil, url: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "YandexMusic", "trackId": trackId, "albumId": albumId, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var trackId: Int? {
            get {
              return resultMap["trackId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "trackId")
            }
          }

          public var albumId: Int? {
            get {
              return resultMap["albumId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "albumId")
            }
          }

          public var url: String? {
            get {
              return resultMap["url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }
      }
    }
  }
}

public final class TastesV2Query: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Tastes_v2 {
      tastes_v2 {
        __typename
        genre
        rating
      }
    }
    """

  public let operationName: String = "Tastes_v2"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("tastes_v2", type: .list(.object(TastesV2.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tastesV2: [TastesV2?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "tastes_v2": tastesV2.flatMap { (value: [TastesV2?]) -> [ResultMap?] in value.map { (value: TastesV2?) -> ResultMap? in value.flatMap { (value: TastesV2) -> ResultMap in value.resultMap } } }])
    }

    public var tastesV2: [TastesV2?]? {
      get {
        return (resultMap["tastes_v2"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [TastesV2?] in value.map { (value: ResultMap?) -> TastesV2? in value.flatMap { (value: ResultMap) -> TastesV2 in TastesV2(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [TastesV2?]) -> [ResultMap?] in value.map { (value: TastesV2?) -> ResultMap? in value.flatMap { (value: TastesV2) -> ResultMap in value.resultMap } } }, forKey: "tastes_v2")
      }
    }

    public struct TastesV2: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Taste_v2"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("genre", type: .scalar(String.self)),
          GraphQLField("rating", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(genre: String? = nil, rating: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Taste_v2", "genre": genre, "rating": rating])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var genre: String? {
        get {
          return resultMap["genre"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "genre")
        }
      }

      public var rating: Int? {
        get {
          return resultMap["rating"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "rating")
        }
      }
    }
  }
}
