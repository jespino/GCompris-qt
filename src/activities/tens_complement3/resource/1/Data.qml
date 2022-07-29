/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Split the 10's complement of the given number")
    difficulty: 1
    data: [
        {
            "value": [
                {
                    "numberValue": [1, 3, 6, 7, 2, 9],
                    "questionValue": [7, 9, 13],
                    "answerValue": [7, "?", "?", 13]
                },
                {
                    "numberValue": [7, 2, 5],
                    "questionValue": [8, 5, 3],
                }
            ]
        }
    ]
}

