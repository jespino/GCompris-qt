/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Find the fraction (simplified fractions with a rectangle).")
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
        {
            "chartType": "rectangle",
            "numerator": 2,
            "denominator": 5,
            "instruction": qsTr("Select two fifths of the rectangle.")
        }
    ]
}
