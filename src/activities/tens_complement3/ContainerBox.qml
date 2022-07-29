/* GCompris - Card.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import "../../core"
import "tens_complement3.js" as Activity

Rectangle {
    color: "#F0CB38"
    border.color: "black"
    border.width: 3
    radius: 15
    property ListModel questionListModel
    property ListModel answerListModel

    Rectangle {
        id: questionContainer
        height: parent.height * 0.4
        width: parent.width * 0.6
        color: "#88A2FE"
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        border.width: 3
        border.color: "black"
        radius: 30

        ListView {
            height: parent.height * 0.9
            width: parent.width * 0.9
            interactive: false
            anchors.centerIn: parent
            orientation: ListView.Horizontal
            model: questionListModel
            delegate: Card {
                height: questionContainer.height * 0.8
                width: questionContainer.width / 8
            }
        }
    }

    Rectangle {
        id: answerContainer
        height: parent.height * 0.4
        width: parent.width * 0.8
        color: "#95F2F8"
        anchors {
            top: questionContainer.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        border.width: 3
        border.color: "black"
        radius: 30

        ListView {
            height: parent.height * 0.9
            width: parent.width * 0.9
            interactive: false
            anchors.centerIn: parent
            orientation: ListView.Horizontal
            model: answerListModel
            delegate: Card {
                height: answerContainer.height * 0.8
                width: answerContainer.width / 10
            }
        }
    }
}
