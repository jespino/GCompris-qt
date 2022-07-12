/* GCompris - Card.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import "../../core"

Item {
    Rectangle {
    color: bgColor
    height: parent.height * 0.8
    width: parent.width
    border.width: 2
    border.color: borderColor
    radius: 20
    anchors.centerIn: parent

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

