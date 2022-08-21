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
                [
                    {
                        "numberValue": [1, 3, 6],
                        "questionValue": [7, 9, 4]
                    },
                    {
                        "numberValue": [7, 2, 5],
                        "questionValue": [8, 5, 3]
                    }
                ],
                [
                    {
                        "numberValue": [1, 3, 7, 4, 9, 2],
                        "questionValue": [6, 9, 7]
                    },
                    {
                        "numberValue": [7, 2, 5, 8, 6, 4],
                        "questionValue": [8, 5, 3]
                    }
                ],
                [
                    {
                        "numberValue": [1, 4, 8, 2, 6, 9],
                        "questionValue": ["?", "?" ,"?"]
                    },
                    {
                        "numberValue": [7, 9, 1, 3, 6, 4],
                        "questionValue": ["?", "?" ,"?"]
                    }
                ]
            ]
        }
    ]
}
