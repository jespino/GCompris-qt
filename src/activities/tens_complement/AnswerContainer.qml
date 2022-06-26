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
        border.width: givenWidth
        border.color: "black"
        radius: 30
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: 10
        }

        Rectangle {
            id: firstPlaceHolder
            height: parent.height
            width: Math.min(firstPlaceHolder.height,parent.width/4)
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            border.width: 2
            border.color: "black"
            color: "yellow"
            radius: parent.radius

            GCText {
                id: textValueFirst
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
                        textValueFirst.text = arr[arr.length - 1]
                    }
                    arr.length = 0
                    Activity.updateVisibility(textValueFirst.text)
                }
            }
        }

        GCText {
            text: "+"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors {
                left: firstPlaceHolder.right
                right: secondPlaceHolder.left
                top: parent.top
                bottom: parent.bottom
            }
        }

        Rectangle {
            id: secondPlaceHolder
            height: firstPlaceHolder.height
            width: firstPlaceHolder.width
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            color: "yellow"
            border.width: 2
            border.color: "black"
            radius: parent.radius

            GCText {
                id: textValueSecond
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
                        textValueSecond.text = arr[arr.length - 1]
                    }
                    arr.length = 0
                    Activity.updateVisibility(textValueSecond.text)
                }
            }
        }

        GCText {
            text: "="
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors {
                left: secondPlaceHolder.right
                right: targetNumber.left
                top: parent.top
                bottom: parent.bottom
            }
        }

        Rectangle {
            id: targetNumber
            height: firstPlaceHolder.height
            width: firstPlaceHolder.width
            anchors.right: parent.right
            color: "yellow"
            border.width: 2
            border.color: "black"
            radius: parent.radius

            GCText {
                height: parent.height
                width: parent.width
                anchors.centerIn: parent
                text: "10"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
