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

for item in library{
    if let song = item as? Song{
        print("song name is \(item.name)")
    }else if let movie = item as? Movie{
        print("movie name is \(movie.name)")
    }
}
