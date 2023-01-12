//
//  Type Casting.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/12.
//

import Foundation

// - Topic: Type Casting

/// 타입 캐스팅은 인스턴스의 타입을 확인하거나, 인스턴스를 슈퍼클래스나 서브클래스로써 처리하는 것을 의미한다.
/// 또한, 스위프트에서는 프로토콜을 따르는지 타입 캐스팅을 통해 확인할 수 있다.
/// as, is 연산자를 통해 타입 캐스팅을 수행할 수 있다.

/// - Defining a Class Hierarchy for Type Casting
/// 타입 캐스팅을 위해 클래스를 설계해보자.
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

/// library 배열에는 Movie 인스턴스와, Song 인스턴스들이 있다.
/// 이 인스턴스들의 공통점은 MediaItem이라는 슈퍼클래스를 상속한다는 점이다.
/// 따라서 스위프트는 이 상수 배열의 타입을 [MediaItem[으로 추론한다.
/// 만약 이 배열을 iterate 한다면, MediaItem 타입의 인스턴스를 얻게 된다.
/// 이를 Move, Song 인스턴스로 다루기 위해서는 타입을 확인하거나, down cast하는 과정이 필요하다.
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

/*------------------------------------------*/

/// - Checking Type
/// 만약, 특정 클래스 인스턴스가 서브 클래스의 인스턴스인지 확인하려면 is연산자를 사용하면 된다.
/// 만약 서브 클래스의 인스턴스가 맞다면 true를 return 하고, 아니라면 false를 return 한다.

var movieCount = 0
var songCount = 0
for item in library{
    if item is Movie{
        movieCount += 1
    }else if item is Song{
        songCount += 1
    }
}

/*------------------------------------------*/

/// - Downcasting
/// 어느 클래스의 인스턴스가 서브 클래스의 인스턴스로 처리하려면 타입 캐스팅 연산자인 as!나 as?를 사용하면 된다.
/// as?는 옵셔널을 return하며, 만약 하위 클래스가 아닌 경우에 nil을 반환한다.
/// as!는 타입 인스턴스를 return하며, 만약 하위 클래스가 아닌 경우에 런타임 에러가 발생한다.
/// 아래의 코드의 경우 as?를 사용하였다, 왜냐하면 각 원소를 iterate할 때 Song 타입인지, Movie 타입인지 확신할 수 없기 때문이다.
/// as? 는 옵셔널 타입을 반환하므로, 이를 해결하기 위해 옵셔널 바인딩을 이용하였다.
for item in library{
    if let song = item as? Song{
        print("song name is \(item.name)")
    }else if let movie = item as? Movie{
        print("movie name is \(movie.name)")
    }
}

/*------------------------------------------*/

/// - Type Casting for Any and AnyObject
/// 스위프트는 Any, AnyObject 타입을 제공한다.
/// Any타입의 경우 클래스, 구조체, 열거형 뿐만 아니라 클로저 인스턴스도 포함된다
/// AnyObject타입의 경우 클래스 인스턴스만 해당된다.
var things: [Any] = []
things.append(0) // Int
things.append(0.0) // Double
things.append(42) // Int
things.append(3.141592) // Double
things.append("hello") // String
things.append((3.0, 5.0)) // (Double, Double)
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman")) // Movie
things.append({ (name: String) -> String in "Hello, \(name)" }) // (String) -> String

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.141592
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called Ghostbusters, dir. Ivan Reitman
// Hello, Michael

/// - Note: Any 타입은 옵셔널 타입을 포함한다.
/// 만약, Any 타입이 예상되는 곳에 옵셔널 타입을 사용한다면 경고가 발생한다 이를 위해 as 연산자를 사용할 수 있다.
let optionalIntValue: Int? = 3
things.append(optionalIntValue) // warning
things.append(optionalIntValue as Any) // no warning
