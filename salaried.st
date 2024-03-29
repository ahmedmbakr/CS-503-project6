Employee subclass: SalariedEmployee [
    |weeklySalary|

    setWeeklySalary: n [
        "An instance method to set the number of hours worked by the employee"
        weeklySalary := n.
    ]

    printInfo [
        "An instance method to get the information of the employee"
        ('Salaried employee: ', super printInfo) displayNl.
        ('weekly salary: ', self getEarning printString) displayNl.
    ]

    getEarning [
        "An instance method to get the earning of the employee"
        ^weeklySalary.
    ]
]
