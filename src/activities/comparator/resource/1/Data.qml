/* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 * Authors:
 *   Aastha Chauhan <aastha.chauhan01@gmail.com>
 *   Harsh Kumar <hadron43@yahoo.com>
 *
 *   SPDX-License-Identifier: GPL-3.0-or-later
 */

import GCompris 1.0

Data {
    objective: qsTr("Digits from 1 to 2.")
    difficulty: 1

    data: [
        {
            minValue: 0,
            maxValue: 10,
            count: 4
        },
        {
            minValue: 11,
            maxValue: 20,
            count: 4
        }
    ]
}
