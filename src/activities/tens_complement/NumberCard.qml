/* GCompris - NumberCard.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12

import "../../core"

Item {
    id: numCard
    Rectangle {
        id: numRect
        height: parent.height
        width: parent.width
        color: "#FFFB9A"
        border.color: "black"
        border.width: 3
        radius: 15

        GCText {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            color: "black"
            text: value
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
