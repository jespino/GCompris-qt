/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("Swapping tens complement among 6 numbers")
    difficulty: 1
    data: [
        {
            "value": [
                {
                    "numberValue": [1, 3, 6, 7, 4, 9],
                    "totalSum": 30
                },
                {
                    "numberValue": [7, 2, 5, 8, 3, 5],
                    "totalSum": 30
                },
                {
                    "numberValue": [1, 4, 8, 6, 9, 2],
                    "totalSum": 30
                }
            ]
        }
    ]
}

