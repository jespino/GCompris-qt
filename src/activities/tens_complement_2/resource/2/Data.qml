/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("10's complement of a given number from 3 cards")
    difficulty: 1
    data: [
        {
            "value": [
                {
                    "numberValue": [1, 3, 6],
                    "questionValue": [7, 9, 4]
                },
                {
                    "numberValue": [7, 2, 5],
                    "questionValue": [8, 5, 3]
                }
            ]
        }
    ]
}
