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
    objective: qsTr("fixed")
    difficulty: 1

    data: [
        {
            random: false,
            values: [[1, 5] , [8, 2], [1, 4]]
        },
        {
            random: false,
            values: [[1, 9] , [4, 2], [3, 4]]
        }
    ]
}

