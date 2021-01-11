import UIKit

//1. Решить квадратное уравнение.

func calculateQuadraticEquation(a: Double, b: Double, c: Double) -> Array<Double> {
    var results = Array<Double>()
    
    let d = b * b - 4 * a * c
    
    if d > 0 {
        let x1 = (-b + sqrt(d)) / (2 * a)
        let x2 = (-b - sqrt(d)) / (2 * a)
        results.append(x1)
        results.append(x2)
    } else if d == 0 {
        let x = -b / (2 * a)
        results.append(x)
    }
    
    return results
}

let results = calculateQuadraticEquation(a: 2, b: 3, c: 1)

print(results)


//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

func area(a: Double, b: Double) -> Double {
    return (a * b) / 2
}

func hypotenus(a: Double, b: Double) -> Double {
    return sqrt(a * a + b * b)
}

func perimetr(a: Double, b: Double) -> Double {
    let c = hypotenus(a: a, b: b)
    return a + b + c
}

area(a: 3, b: 4)
hypotenus(a: 3, b: 4)
perimetr(a: 3, b: 4)


