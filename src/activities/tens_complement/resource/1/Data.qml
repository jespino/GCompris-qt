/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Pairs of 10's complement")
    difficulty: 1
    data: [
        {
            "value": [
                {
                    "numberValue": [1, 3, 9],
                    "questionValue": [7, 1, 9]
                },
                {
                    "numberValue": [7, 2, 5],
                    "questionValue": [8, 5, 3]
                }
            ]
        }
    ]
}
