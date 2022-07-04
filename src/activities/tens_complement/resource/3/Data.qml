/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("pairs of 10's complement")
    difficulty: 1
    data: [
        {
            "value": [
                {
                    "numberValue": [1, 4, 8, 2, 6, 9],
                    "questionValue": ["?", "?" ,"?"]
                },
                {
                    "numberValue": [7, 5, 5, 8, 6, 4],
                    "questionValue": ["?", "?" ,"?"]
                }
            ]
        }
    ]
}

