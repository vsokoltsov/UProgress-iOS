//
//  BarChartViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Charts
import UIColor_Hex_Swift

class BarChartViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setData(statistics: [StatisticsItem]!) {
        var dataEntries: [BarChartDataEntry] = []
        var colors: [NSUIColor] = []
        for var i in (0..<statistics.count) {
            let item: StatisticsItem! = statistics[i]
            let dataEntry = BarChartDataEntry(x: Double(i), y: item.value)
//                /PieChartDataEntry(value: item.value, label: item.label)
            dataEntries.append(dataEntry)
            colors.append(UIColor(item.color))
//
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Test")
        chartDataSet.setColors(colors, alpha: 1.0)
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }
}
