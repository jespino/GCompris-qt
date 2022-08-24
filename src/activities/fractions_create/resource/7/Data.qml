/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Find the value represented by a percentage (with a rectangle).")
    difficulty: 3

    data: [
        // third dataset with percentage (maybe specific activity?)
        {
            "chartType": "rectangle",
            "numerator": 1,
            "denominator": 2,
            //: Select %1 percent of the rectangle.
            "instruction": qsTr("Select %1% of the rectangle.").arg(50)
        },
        {
            "chartType": "rectangle",
            "numerator": 3,
            "denominator": 10,
            //: Select %1 percent of the rectangle.
            "instruction": qsTr("Select %1% of the rectangle.").arg(30)
        },
        {
            "chartType": "rectangle",
            "numerator": 9,
            "denominator": 12,
            //: Select %1 percent of the rectangle.
            "instruction": qsTr("Select %1% of the rectangle.").arg(75)
        }
    ]
}
