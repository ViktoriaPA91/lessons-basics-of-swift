//: A UIKit based Playground for presenting user interface
  
import UIKit

// 1. Написать функцию, которая определяет, четное число или нет.

func isEvenNumber(a: Int) -> Bool {
    return a % 2 == 0
}
   
func printIsEvenNumber(a: Int) {
    let message = isEvenNumber(a: a) ? "Число \(a) четное" : "Число \(a) нечетное"
    print(message)
}

printIsEvenNumber(a: 7)


// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.


func isDivisibleByThree(_ a: Int) -> Bool {
    return a % 3 == 0
}
   
func printIsDivisibleByThree(_ a: Int) {
    if isDivisibleByThree(a) {
        print("Число \(a) делится без остатка на 3")
    } else {
        print("Число \(a) не делится без остатка на 3")
    }
}

printIsDivisibleByThree(9)


// 3. Создать возрастающий массив из 100 чисел.

var numbers = [Int]()
for i in 1...100 {
    numbers.append(i)
}

print(numbers)


// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.


for v in numbers {
    if v % 2 == 0 || v % 3 != 0 {
        numbers.remove(at: numbers.firstIndex(of: v)!)
    }
}

print(numbers)


// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.


var fibonachiNumbers = [Double]()

func nextNumberFibonachi(of list: [Double]) -> Double {
    if list.count == 0 {
        return 0
    } else if list.count == 1 {
        return 1
    } else {
        let lastNumberFibonachi = list[list.count - 1]
        let prevLastNumberFibonachi = list[list.count - 2]
        return lastNumberFibonachi + prevLastNumberFibonachi
    }
}

for _ in 1...100 {
    let nextNumber = nextNumberFibonachi(of: fibonachiNumbers)
    fibonachiNumbers.append(nextNumber)
}

print(fibonachiNumbers)
