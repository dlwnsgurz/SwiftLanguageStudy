var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
// 함수를 {} 감쌌다. 하지만 remove 함수는 실행되지 않는다.
// 또한, 위 상수는 클로저이며 타입은 () -> String 타입이다.
// 왜냐하면, 자동 클로저이므로 인자가 없고 표현내의 값이 자동클로저의 return 타입이 되기 때문이다.

print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

/// 자동 클로저를 사용하지 않고, 직접 클로저를 인자로 전달한 경우이다.
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"

/// 자동 클로저를 사용해, 인자를 전달하는 경우는 다음과 같다.
func serve(customer customerProvide: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customerProvider)
serve(customer: customersInLine.remove(at:0))

/// 또한 @autocloser와 @escapingclosure 를 동시에 사용할 수 있다.
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"
