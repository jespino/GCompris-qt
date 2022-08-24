/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Fixed denominator with a pie.")
    difficulty: 3

    data: [
        {
            // TODO do some Math.random(1, denominator)
            "chartType": "pie",
            "numerator": 1,
            "denominator": 2,
            "fixedNumerator": false,
            "fixedDenominator": true,
            "instruction": qsTr("Find the represented fraction.")
        },
        {
            "chartType": "pie",
            "numerator": 3,
            "denominator": 10,
            "fixedNumerator": false,
            "fixedDenominator": true,
            "instruction": qsTr("Find the represented fraction.")
        },
        {
            "chartType": "pie",
            "numerator": 9,
            "denominator": 12,
            "fixedNumerator": false,
            "fixedDenominator": true,
            "instruction": qsTr("Find the represented fraction.")
        }
    ]
}
