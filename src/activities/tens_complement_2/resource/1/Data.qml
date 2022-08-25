/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import GCompris 1.0

Data {
    objective: qsTr("First Dataset")
    difficulty: 1
    data: [
        {
            "value": [
                [
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
                ],
                [
                    {
                        "numberValue": [1, 3, 6, 7, 4],
                        "totalSum": 21
                    },
                    {
                        "numberValue": [7, 2, 5, 8, 3],
                        "totalSum": 25
                    },
                    {
                        "numberValue": [1, 4, 8, 6, 9],
                        "totalSum": 28
                    }
                ],
                [
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
            ]
        }
    ]
}
