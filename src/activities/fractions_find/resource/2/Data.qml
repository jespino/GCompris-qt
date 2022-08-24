/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Fixed numerator with a pie.")
    difficulty: 3

    data: [
        {
            "chartType": "pie",
            "numerator": 1,
            "denominator": 2,
            "fixedNumerator": true,
            "fixedDenominator": false,
            "instruction": qsTr("Find the represented fraction.")
        },
        {
            "chartType": "pie",
            "numerator": 3,
            "denominator": 10,
            "fixedNumerator": true,
            "fixedDenominator": false,
            "instruction": qsTr("Find the represented fraction.")
        },
        {
            "chartType": "pie",
            "numerator": 9,
            "denominator": 12,
            "fixedNumerator": true,
            "fixedDenominator": false,
            "instruction": qsTr("Find the represented fraction.")
        }
    ]
}
