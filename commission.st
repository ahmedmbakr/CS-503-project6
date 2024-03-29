Employee subclass: CommissionEmployee [
    |salesAmount commissionRate minWeekPay|

    setSalesAmount: n [
        "An instance method to set the sales amount of the employee"
        salesAmount := n.
    ]

    setCommissionRate: n [
        "An instance method to set the commission rate of the employee"
        commissionRate := n.
    ]

    setMinWeekPay: n [
        "An instance method to set the minimum weekly pay of the employee"
        minWeekPay := n.
    ]

    printInfo [
        "An instance method to get the information of the employee"
        ('Commission employee: ', super printInfo) displayNl.
        ('minimum salary: ', (minWeekPay * 1.0) printString, ', sales amount: ', (salesAmount * 1.0) printString, ', commission rate: ', (commissionRate * 100.0) printString, '%') displayNl.
    ]

    getEarning [
        "An instance method to get the earning of the employee"
        |computedCommission|
        computedCommission := commissionRate * salesAmount.
        computedCommission > minWeekPay 
            ifTrue: [^computedCommission] 
            ifFalse: [^(minWeekPay * 1.0)].
    ]
]
