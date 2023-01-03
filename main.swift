let stillAnotherPoint = (9, "a")
switch stillAnotherPoint {
case (let distance, "a"), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
