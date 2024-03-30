Employee subclass: HourlyEmployee [
    |numHours hoursRate|

    setNumHours: n [
        "An instance method to set the number of hours worked by the employee"
        numHours := n.
    ]

    setHourlyRate: r [
        "An instance method to set the hourly rate of the employee"
        hoursRate := r.
    ]

    printInfo [
        "An instance method to get the information of the employee"
        ('Hourly employee: ', super printInfo) displayNl.
        ('hours worked: ', (numHours * 1.0) printString, ', hourly rate: ', hoursRate printString) displayNl.
    ]

    getEarning [
        "An instance method to get the earning of the employee"
        |fixedHours overtimeHours1 overtimeHours2|
        numHours <=40 ifTrue: [fixedHours := numHours] ifFalse: [fixedHours := 40].
        numHours>40 ifTrue: [overtimeHours1 := numHours - 40] ifFalse: [overtimeHours1 := 0].
        overtimeHours1 > 10 ifTrue: [overtimeHours1 := 10].
        numHours > 50 ifTrue: [overtimeHours2 := numHours - 50] ifFalse: [overtimeHours2 := 0].
        ^(fixedHours * hoursRate) + (overtimeHours1 * hoursRate * 1.5) + (overtimeHours2 * hoursRate * 2).
    ]
]