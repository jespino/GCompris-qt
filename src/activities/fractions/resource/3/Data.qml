/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Find the value.")
    difficulty: 3

    data: [
        {
            "numerator": 1,
            "denominator": 2,
            "fixedNumerator": false,
            "fixedDenominator": false,
            "instruction": qsTr("Find the represented fraction.")
        },
        {
            "numerator": 3,
            "denominator": 10,
            "fixedNumerator": false,
            "fixedDenominator": true,
            "instruction": qsTr("Find the represented fraction.")
        },
        {
            "numerator": 9,
            "denominator": 12,
            "fixedNumerator": true,
            "fixedDenominator": false,
            "instruction": qsTr("Find the represented fraction.")
        },
        // same with percentage?
        {
            "numerator": 3,
            "denominator": 7,
            "instruction": qsTr("Find the corresponding percentage.")
        }
    ]
}
