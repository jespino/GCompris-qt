/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Find the value (non simplified fractions with a pie chart).")
    difficulty: 3

    data: [
        // second dataset with multipliers
        {
            "chartType": "pie",
            "numerator": 2,
            "denominator": 4,
            "instruction": qsTr("Select half of the pie.")
        },
        {
            "chartType": "pie",
            "numerator": 4,
            "denominator": 8,
            "instruction": qsTr("Select half of the pie.")
        },
        {
            "chartType": "pie",
            "numerator": 5,
            "denominator": 10,
            "instruction": qsTr("Select half of the pie.")
        },
        {
            "chartType": "pie",
            "numerator": 2,
            "denominator": 6,
            "instruction": qsTr("Select a third of the pie.")
        },
        {
            "chartType": "pie",
            "numerator": 6,
            "denominator": 9,
            "instruction": qsTr("Select two thirds of the pie.")
        },
        {
            "chartType": "pie",
            "numerator": 2,
            "denominator": 8,
            "instruction": qsTr("Select a quarter of the pie.")
        },
        {
            "chartType": "pie",
            "numerator": 4,
            "denominator": 10,
            "instruction": qsTr("Select two fifths of the pie.")
        }
    ]
}
