func swapTwoInts(_ a: inout Int, _ b: inout Int){
    var temp = a
    a = b
    b = temp
}

var someInt1 = 3
var someInt2 = 7
swapTwoInts(&someInt1, &someInt2)
print("\(someInt1), \(someInt2)")

func addTwoInts(_ a: Int, _ b: Int) -> Int{
    a+b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int{
    a*b
}
