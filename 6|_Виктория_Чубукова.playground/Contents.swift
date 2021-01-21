import UIKit

struct Queue<T> {
    private var elements: [T] = []
    var count: Int { elements.count }
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        return elements.removeFirst()
    }
    
    func filter(_ by: (T) -> Bool) -> Queue<T> {
        var queue = Queue<T>()
        elements.filter(by).forEach(){ queue.enqueue($0) }
        return queue
    }
    
    func count(by predicate: (T) -> Bool) -> Int {
        return elements.filter(predicate).count
    }
    
    func map<X>(transform: (T) -> X) -> Queue<X> {
        var queue = Queue<X>()
        elements.forEach(){ queue.enqueue(transform($0)) }
        return queue
    }
    
    subscript (index: Int) -> T? {
        if 0 ..< elements.count ~= index {
            return elements[index]
        }
        return nil
    }
}

var queue1 = Queue<Int>()
queue1.enqueue(1)
queue1.enqueue(2)
queue1.enqueue(3)
queue1.enqueue(4)
queue1.enqueue(5)
print(queue1.count)
print(queue1.count(){ $0 < 4 })
print(queue1.count(){ $0 % 2 == 0 })
print(queue1.filter(){ $0 % 3 == 0})
print(queue1.map(){ "\($0)" })

print(
    queue1
        .filter(){ $0 % 2 == 0 }
        .map(){ "\($0)" }
        .count
)

print(queue1[6])

