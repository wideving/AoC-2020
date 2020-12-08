import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.split(separator: "\n")

//Day5
struct Seat {
    let row: String
    let column: String
}

var seats = inputs.map { input -> Seat in
    Seat(row: String(input.dropLast(3)), column: String(input.dropFirst(7)))
}

func calculateRow(seat: Seat) -> Int {
    var rows = (0..<128).map { Int($0) }
    seat.row.forEach { char in
        rows = Array(char == "F" ? rows.dropLast(rows.count / 2) : rows.dropFirst(rows.count / 2))
    }
    
    var columns = (0..<8).map { Int($0) }
    seat.column.forEach { char in
        columns = Array(char == "R" ? columns.dropFirst(columns.count / 2) : columns.dropLast(columns.count / 2))
    }

    return rows[0] * 8 + columns[0]
}

let sortedSeats = seats.map { calculateRow(seat: $0) }.sorted()

print(sortedSeats.last!)

//Day5.5
var seatId = 0

for i in 0..<sortedSeats.count - 1 {
    if sortedSeats[i] + 2 == sortedSeats[i+1] {
        seatId = sortedSeats[i] + 1
    }
}

print(seatId)








