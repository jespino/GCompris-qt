/* GCompris - CardContainer.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import "../../core"


Rectangle {
    id: cardContainer
    color: "#95F2F8"
    border.color: "black"
    border.width: 3
    radius: 20
    property ListModel listmodel

    ListView {
        height: parent.height
        width: parent.width
        anchors {
            left: parent.left
            right: parent.right
            leftMargin: 5
            rightMargin: 5
            centerIn: parent
        }
        orientation: ListView.Horizontal
        model: listmodel
        delegate: Card {
                height: parent.height
                width: cardContainer.width/14
            }
        }
}
