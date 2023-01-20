enum Barcode{
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}

/// 연관 값을 이용해보자.
var myBarcode = Barcode.upc(123,412,13,243)
myBarcode = .qrCode("adnjasndj")

/// 연관 값에 이름을 지어줄 수도 있다.
enum AppleProduct{
    case IPad(model: String, version: Double)
    case Mac(model: String, version: Double)
    case IPhone(model: String, version: String)
}
let a = [1,2,3,4,5]

/// switch문과 관련값을 이용해 보자.
switch myBarcode{
case let .upc(a,b,c,d):
    print("\(a) \(b) \(c) \(d)")
case let .qrCode(sentence):
    print("\(sentence)")
}
