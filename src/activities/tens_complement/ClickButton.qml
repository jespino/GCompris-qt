/* GCompris - ClickButton.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12

import "../../core"

Rectangle {
    id: clickButton
    color: "#F0CB38"
    border.width: 3
    border.color: "black"
    radius: 30
    property string textValue

    GCText {
        anchors.fill: parent
        anchors.margins: parent.height * 0.1
        text: textValue
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            parent.border.color = "#76F361"
        }
        onExited: {
            parent.border.color = "black"
        }
    }
}
