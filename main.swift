import Foundation
indirect enum ArithmeticExpression{
    case number(Int)
    case addtion(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let four = ArithmeticExpression.number(4)
let five = ArithmeticExpression.number(5)
let sum = ArithmeticExpression.addtion(four,five)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int{
    switch expression{
    case let .number(value):
        return value
    case let .addtion(exp1, exp2):
        return evaluate(exp1) + evaluate(exp2)
    case let .multiplication(exp1, exp2):
        return evaluate(exp1) * evaluate(exp2)
    }
}

print(evaluate(product))
