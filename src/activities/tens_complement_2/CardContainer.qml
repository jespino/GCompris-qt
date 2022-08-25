/* GCompris - CardContainer.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import "../../core"

Item {
    property ListModel listmodel
    property int numberOfCards
    property string validationImage
    Rectangle {
        id: cardContainer
        color: "#95F2F8"
        height: parent.height
        width: parent.width * 0.9
        border.color: "black"
        border.width: 3
        radius: 20

        ListView {
            height: parent.height
            width: parent.width
            interactive: false
            orientation: ListView.Horizontal
            model: listmodel
            delegate: Card {
                height: cardContainer.height
                width: cardContainer.width / numberOfCards
            }
        }
    }

    Image {
        id: test
        height: cardContainer.height * 0.65
        width: cardContainer.height * 0.65
        source: validationImage
        anchors {
            left: cardContainer.right
            leftMargin: 5
            verticalCenter: cardContainer.verticalCenter
        }
    }
}
