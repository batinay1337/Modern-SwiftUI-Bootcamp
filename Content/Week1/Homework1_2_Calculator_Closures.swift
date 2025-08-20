import Foundation

/*
 Homework 1.2 – Functions and Closures
 Calculator and Array Operations
 
 In this file, we will write basic calculator functions and use closures to perform array operations.
 */

// MARK: - Calculator Functions

/// Enum for basic calculator operations
enum CalculatorOperation {
    case addition
    case subtraction
    case multiplication
    case division
}

/// Enum for calculator errors
enum CalculatorError: Error {
    case divisionByZero
    case invalidOperation
    
    var description: String {
        switch self {
        case .divisionByZero:
            return "Division by zero error!"
        case .invalidOperation:
            return "Invalid operation!"
        }
    }
}

// MARK: - Basit Hesap Makinesi Fonksiyonları

/// Addition operation

func add(_ a: Double, _ b: Double) -> Double {
    return a + b
}

/// Subtraction operation

func subtract(_ a: Double, _ b: Double) -> Double {
    return a - b
}

/// Multiplication operation

func multiply(_ a: Double, _ b: Double) -> Double {
    return a * b
}

/// Division operation (with error handling)

func divide(_ a: Double, _ b: Double) throws -> Double {
    guard b != 0 else {
        throw CalculatorError.divisionByZero
    }
    return a / b
}

// MARK: - Gelişmiş Hesap Makinesi Yapısı

struct Calculator {
    
    /// Generic calculation function

    func calculate(_ a: Double, _ b: Double, operation: CalculatorOperation) throws -> Double {
        switch operation {
        case .addition:
            return add(a, b)
        case .subtraction:
            return subtract(a, b)
        case .multiplication:
            return multiply(a, b)
        case .division:
            return try divide(a, b)
        }
    }
    
    /// Calculation function using closuress
    func calculateWithClosure(_ a: Double, _ b: Double, operation: (Double, Double) -> Double) -> Double {
        return operation(a, b)
    }
    
    func calculateWithThrowingClosure(_ a: Double, _ b: Double, operation: (Double, Double) throws -> Double) throws -> Double {
        return try operation(a, b)
    }
    

    func calculateMultiple(_ numbers: [Double], operation: (Double, Double) -> Double) -> Double? {
        guard !numbers.isEmpty else { return nil }
        return numbers.reduce(numbers[0]) { result, number in
            return operation(result, number)
        }
    }
}

// MARK: - Closure Örnekleri ve Dizi İşlemleri

struct ArrayProcessor {
    
    /// Filtering the array - odd numbers

    func filterOddNumbers(_ numbers: [Int]) -> [Int] {
        return numbers.filter { $0 % 2 != 0 }
    }
    
    func filterEvenNumbers(_ numbers: [Int]) -> [Int] {
        return numbers.filter { $0 % 2 == 0 }
    }
    
    /// Custom filtering

    func filter(_ numbers: [Int], condition: (Int) -> Bool) -> [Int] {
        return numbers.filter(condition)
    }
    
    /// Sorting the array
    func sort(_ numbers: [Int], ascending: Bool = true) -> [Int] {
        if ascending {
            return numbers.sorted { $0 < $1 }
        } else {
            return numbers.sorted { $0 > $1 }
        }
    }
    
    /// Custom sorting
    func sort(_ numbers: [Int], by comparator: (Int, Int) -> Bool) -> [Int] {
        return numbers.sorted(by: comparator)
    }

    func map<T>(_ numbers: [Int], transform: (Int) -> T) -> [T] {
        return numbers.map(transform)
    }
    
    /// Array reduction
    func reduce<T>(_ numbers: [Int], initialValue: T, operation: (T, Int) -> T) -> T {
        return numbers.reduce(initialValue, operation)
    }
}

// MARK: - Gerçek Hayat Örnekleri

struct RealWorldExamples {
    
    /// Operations for student grade
    struct StudentGrades {
        let name: String
        let grades: [Double]
        
        var average: Double {
            guard !grades.isEmpty else { return 0 }
            return grades.reduce(0, +) / Double(grades.count)
        }
        
        var passed: Bool {
            return average >= 50.0
        }
        
        var letterGrade: String {
            switch average {
            case 90...100: return "AA"
            case 80..<90: return "BA"
            case 70..<80: return "BB"
            case 60..<70: return "CB"
            case 50..<60: return "CC"
            default: return "FF"
            }
        }
    }
    
    /// Operations for student list

    func processStudents(_ students: [StudentGrades]) -> [String] {
        return students
            .filter { $0.passed }  
            .sorted { $0.average > $1.average }  
            .map { "\($0.name): \($0.letterGrade) (\(String(format: "%.1f", $0.average)))" }  
    }
    
    /// Operations for shopping list
    struct ShoppingItem {
        let name: String
        let price: Double
        let quantity: Int
        
        var totalPrice: Double {
            return price * Double(quantity)
        }
    }
    

    func processShoppingCart(_ items: [ShoppingItem]) -> (total: Double, expensiveItems: [String], cheapItems: [String]) {
        let total = items.reduce(0.0) { $0 + $1.totalPrice }
        
        let expensiveItems = items
            .filter { $0.totalPrice > 100.0 }
            .map { $0.name }
        
        let cheapItems = items
            .filter { $0.totalPrice <= 50.0 }
            .map { $0.name }
        
        return (total, expensiveItems, cheapItems)
    }
}

// MARK: - Demo and Test Functions

func demonstrateCalculator() {
    print("🧮 Ödev 1.2 – Functions and Closures Demo")
    print("")
    
    let calculator = Calculator()
    
    // Basic function examples
    print("📱 Basic Calculator Functions")
    print("=" * 45)
    
    let a: Double = 15.5
    let b: Double = 4.2
    
    print("Numbers: \(a) and \(b)")
    print("Addition: \(a) + \(b) = \(add(a, b))")
    print("Subtraction: \(a) - \(b) = \(subtract(a, b))")
    print("Multiplication: \(a) × \(b) = \(multiply(a, b))")
    
    do {
        let divisionResult = try divide(a, b)
        print("Division: \(a) ÷ \(b) = \(String(format: "%.2f", divisionResult))")
    } catch {
        print("Division error: \(error)")
    }
    
    // Division by zero example
    do {
        let _ = try divide(a, 0)
    } catch let error as CalculatorError {
        print("Error caught: \(error.description)")
    } catch {
        print("Unknown error: \(error)")
    }
    
    print("")
    
    // Closure examples
    print("🔗 Closure Examples")
    print("=" * 30)
    
    // Basic closures
    let addClosure: (Double, Double) -> Double = { x, y in x + y }
    let subtractClosure: (Double, Double) -> Double = { x, y in x - y }
    let multiplyClosure: (Double, Double) -> Double = { x, y in x * y }
    
    print("Closure ile toplama: \(calculator.calculateWithClosure(a, b, operation: addClosure))")
    
        // Short syntax
    print("Short closure addition: \(calculator.calculateWithClosure(a, b, operation: { $0 + $1 }))")
    
    // Trailing closure
    let multiplicationResult = calculator.calculateWithClosure(a, b) { $0 * $1 }
    print("Trailing closure multiplication: \(multiplicationResult)")
    
    print("")
    
    // Array operations
    print("📊 Array Operations and Filtering")
    print("=" * 35)
    
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 23, 42, 7, 3]
    let processor = ArrayProcessor()
    
    print("Original array: \(numbers)")
    
    // Filtering
    let oddNumbers = processor.filterOddNumbers(numbers)
    let evenNumbers = processor.filterEvenNumbers(numbers)
    print("Odd numbers: \(oddNumbers)")
    print("Even numbers: \(evenNumbers)")
    
    // Custom filtering
    let bigNumbers = processor.filter(numbers) { $0 > 10 }
    print("Numbers greater than 10: \(bigNumbers)")
    
    // Sorting
    let ascending = processor.sort(numbers)
    let descending = processor.sort(numbers, ascending: false)
    print("Ascending order: \(ascending)")
    print("Descending order: \(descending)")
    
    // Custom sorting - absolute value
    let absoluteSort = processor.sort([-5, 3, -2, 8, -1]) { abs($0) < abs($1) }
    print("Sorting by absolute value: \(absoluteSort)")
    
    // Map operations
    let squared = processor.map(numbers) { $0 * $0 }
    print("Squares: \(squared)")
    
    let strings = processor.map(numbers) { "Number: \($0)" }
    print("String conversion: \(strings.prefix(3))...")
    
    // Reduce operations
    let sum = processor.reduce(numbers, initialValue: 0) { $0 + $1 }
    let product = processor.reduce([1, 2, 3, 4, 5], initialValue: 1) { $0 * $1 }
    print("Sum: \(sum)")
    print("Product (1-5): \(product)")
    
    print("")
}

func demonstrateRealWorldExamples() {
    print("🌍 Real World Examples")
    print("=" * 30)
    
    let examples = RealWorldExamples() 
    
    // Student grades example
    let students = [
        RealWorldExamples.StudentGrades(name: "Ahmet", grades: [85, 92, 78, 88, 91]),
        RealWorldExamples.StudentGrades(name: "Ayşe", grades: [76, 81, 85, 79, 83]),
        RealWorldExamples.StudentGrades(name: "Mehmet", grades: [45, 52, 48, 41, 47]),
        RealWorldExamples.StudentGrades(name: "Fatma", grades: [95, 98, 92, 96, 99]),
        RealWorldExamples.StudentGrades(name: "Ali", grades: [67, 72, 69, 74, 71])
    ]
    
    print("🎓 Student Grades Analysis")
    let results = examples.processStudents(students)
    for result in results {
        print("   \(result)")
    }
    
    print("")
    
    // Shopping cart example
    let shoppingItems = [
        RealWorldExamples.ShoppingItem(name: "Laptop", price: 2500.0, quantity: 1),
        RealWorldExamples.ShoppingItem(name: "Mouse", price: 25.0, quantity: 2),
        RealWorldExamples.ShoppingItem(name: "Klavye", price: 150.0, quantity: 1),
        RealWorldExamples.ShoppingItem(name: "Kitap", price: 35.0, quantity: 3),
        RealWorldExamples.ShoppingItem(name: "Kalem", price: 5.0, quantity: 10)
    ]
    
    print("🛒 Shopping Cart Analysis")
    let cartResult = examples.processShoppingCart(shoppingItems)
    print("   Total: \(String(format: "%.2f", cartResult.total)) TL")
    print("   Expensive items (>100 TL): \(cartResult.expensiveItems)")
    print("   Cheap items (≤50 TL): \(cartResult.cheapItems)")
    
    print("")
}

func demonstrateFunctionsAndClosures() {
    demonstrateCalculator()
    demonstrateRealWorldExamples()
    
    print("✅ Homework 1.2 completed!")
    print("📋 Learned topics:")
    print("   • Basic function writing")
    print("   • Error handling (throws/try/catch)")
    print("   • Closure definition and usage")
    print("   • Trailing closure syntax")
    print("   • Higher-order functions (map, filter, reduce, sorted)")
    print("   • Real world examples")
    print("")
    
    // Bonus: Complex closure example
    print("🎯 Bonus: Complex Closure Example")
    print("=" * 40)
    
    let complexNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    let complexResult = complexNumbers
        .filter { $0 % 2 == 0 }  // Even numbers
        .map { $0 * $0 }         // Squares
        .filter { $0 > 10 }      // Numbers greater than 10
        .sorted { $0 > $1 }      // Descending order
        .prefix(3)               // First 3
    
    print("Operation: even numbers → squares → >10 → descending order → first 3")
    print("Result: \(Array(complexResult))")
    print("")
} 