 /* GCompris - Data.qml
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 * Authors:
 *   Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 *   SPDX-License-Identifier: GPL-3.0-or-later
 */

import GCompris 1.0

Data {
    objective: qsTr("Digits from 1 to 1000000.")
    difficulty: 2

    data: [
        {
            minValue: 1,
            maxValue: 5000000,
            count: 4
        },
        {
            minValue: 5000001,
            maxValue: 1000000,
            count: 4
        }
    ]
}

