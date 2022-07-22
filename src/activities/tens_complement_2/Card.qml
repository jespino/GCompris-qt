/* GCompris - Card.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import "../../core"
import "tens_complement_2.js" as Activity

Item {
    Rectangle {
        color: bgColor
        height: (selected) ? parent.height : parent.height * 0.8
        width: (selected) ? parent.width : parent.width * 0.9
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
            wrapMode: Text.WordWrap
            fontSizeMode: Text.Fit
            font.pointSize: parent.width + 1 // QFont::setPointSizeF: must be greater than 0.
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(type == 1 && numberCardPosition != totalNumberCards) {
                    Activity.resize(rowNumber-1, columnNumber-1);
                    Activity.numberArray.push([columnNumber, rowNumber, numberCardPosition]);
                    Activity.swapNumberCards();
                }
            }
        }
    }
}

