/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("swapping tens complement among 4 numbers")
    difficulty: 1
    data: [
        {
            "value": [
                {
                    "numberValue": [8, 1, 9, 2],
                    "totalSum": 20
                },
                {
                    "numberValue": [7, 5, 3, 5],
                    "totalSum": 20
                },
                {
                    "numberValue": [4, 9, 1, 6],
                    "totalSum": 20
                }
            ]
        }
    ]
}
