/* GCompris - Card.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import "../../core"
import "tens_complement3.js" as Activity

Rectangle {
    visible: visibility
    height: cardSize * 0.9
    width: cardSize * 0.9
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

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Activity.initialSize()
            Activity.selected = index
            Activity.updateSize()
            Activity.numArray.push(index)
        }
    }
}

