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
    property int numberOfCards

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
