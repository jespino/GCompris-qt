/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Find the value from questions (with a pie chart).")
    difficulty: 3

    data: [
        {
            "chartType": "pie",
            "numerator": 2,
            "denominator": 5,
            "instruction": qsTr("Select as much parts as you can without taking more than half of the pie.")
        },
        {
            "chartType": "pie",
            "numerator": 3,
            "denominator": 7,
            "instruction": qsTr("Select the closest number of parts of the pie to the half but less than the half.")
        },
    ]
}
