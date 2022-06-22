/* GCompris - NumberCard.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12

import "../../core"
import "tens_complement.js" as Activity

Item {
    id: answerContainer
    Rectangle {
        id: answerRectangle
        height: parent.height
        width: parent.width
        color: "#95F2F8"
        border.width: 2
        border.color: "black"
        radius: 30
        Rectangle {
            height: parent.height - (parent.height * 0.1)
            width: parent.height - (parent.height * 0.1)
            anchors.margins: 2
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            color: "yellow"
            radius: parent.radius

            GCText {
                id: textValue
                height: parent.height
                width: parent.width
                anchors.centerIn: parent
                text: "?"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var arr = Activity.numArray
                    if(arr.length > 0) {
                        textValue.text = arr[arr.length - 1]
                    }
                    arr.length = 0
                    Activity.updateVisibility(textValue.text)
                }
            }
        }
    }
}
