struct Resolution{
    var width = 0
    var height = 0
}

class VideoMode{
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name : String?
}



let tenEighty = VideoMode()
tenEighty.frameRate = 25.0
tenEighty.interlaced = true
tenEighty.resolution = Resolution(width: 1, height: 1)
tenEighty.name = "1080i"

let alsoTenEighty = tenEighty
alsoTenEighty.name = "1080i2"

print("alsoTenEighty.name = \(alsoTenEighty.name), tenEighty.name = \(tenEighty.name)")
