/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Find the value (rectangle).")
    difficulty: 3

    data: [
        {
            "chartType": "rectangle",
            "numerator": 1,
            "denominator": 2,
            "instruction": qsTr("Select half of the rectangle.")
        },
        {
            "chartType": "rectangle",
            "numerator": 1,
            "denominator": 3,
            "instruction": qsTr("Select a third of the rectangle.")
        },
        {
            "chartType": "rectangle",
            "numerator": 2,
            "denominator": 3,
            "instruction": qsTr("Select two thirds of the rectangle.")
        },
        {
            "chartType": "rectangle",
            "numerator": 1,
            "denominator": 4,
            "instruction": qsTr("Select a quarter of the rectangle.")
        },
        // second dataset with multipliers
        {
            "chartType": "rectangle",
            "numerator": 3,
            "denominator": 6,
            "instruction": qsTr("Select half of the rectangle.")
        },
        // third dataset with percentage (maybe specific activity?)
        {
            "chartType": "rectangle",
            "numerator": 1,
            "denominator": 2,
            "instruction": qsTr("Select 50% of the rectangle.")
        },
        {
            "chartType": "rectangle",
            "numerator": 3,
            "denominator": 10,
            "instruction": qsTr("Select 30% of the rectangle.")
        },
        {
            "chartType": "rectangle",
            "numerator": 9,
            "denominator": 12,
            "instruction": qsTr("Select 75% of the rectangle.")
        },
        // fourth dataset with questions?
        {
            "chartType": "rectangle",
            "numerator": 3,
            "denominator": 7,
            "instruction": qsTr("Select the closest number of parts of the rectangle to the half but less than the half.")
        }
    ]
}
