/* GCompris - tens_complement_2.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12

import "../../core"
import "../tens_complement/"
import "tens_complement_2.js" as Activity

ActivityBase {
    id: activity

    onStart: focus = true
    onStop: {}

    pageComponent: Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
        signal start
        signal stop

        Component.onCompleted: {
            activity.start.connect(start)
            activity.stop.connect(stop)
        }

        // Add here the QML items you need to access in javascript
        QtObject {
            id: items
            property Item main: activity.main
            property alias background: background
            property alias bar: bar
            property alias bonus: bonus
            property alias cardListModel: cardListModel
            property alias symbolListMode: symbolListMode
        }

        onStart: { Activity.start(items) }
        onStop: { Activity.stop() }

        Item {
            id: layoutArea
            anchors.top: parent.top
            anchors.bottom: bar.top
            anchors.bottomMargin: bar.height * 0.2
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ListModel {
            id: cardListModel
        }

        ListModel {
            id: symbolListMode
        }

        Rectangle {
            id: containerHolder
            parent: layoutArea
            height: layoutArea.height * 0.7
            width: layoutArea.width * 0.4
            color: "pink"
            anchors.centerIn: parent

            ListView {
                height: parent.height
                width: parent.width
                anchors.fill: parent
                anchors.leftMargin: 20
                spacing: 50
                orientation: ListView.Horizontal
                anchors.centerIn: parent
                model: cardListModel
                delegate: NumberCard {
                    height: 100
                    width: 100
                }
            }
            ListView {
                height: parent.height
                width: parent.width
                spacing: 148
                orientation: ListView.Horizontal
                anchors.centerIn: parent
                model: symbolListMode
                delegate: SymbolCard {
                    height: 100
                    width: 0
                }
            }
        }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
        }

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }
    }

}
