/* GCompris - tens_complement3.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12
import "../../core"
import "tens_complement3.js" as Activity
import "qrc:/gcompris/src/core/core.js" as Core

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
            property double cardSize: Core.fitItems(numberContainer.width, numberContainer.height, 6)
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
        Rectangle {
            id: numberContainer
            parent: layoutArea
            height: parent.height * 0.4
            width: parent.width * 0.32
            anchors {
                left: layoutArea.left
                verticalCenter: parent.verticalCenter
                leftMargin: layoutArea.width * 0.02
            }
            color: "pink"
            border.width: 2
            border.color: "black"
            radius: 30

            GridView {
                id: container
                height: parent.height
                width: parent.width
                interactive: false
                anchors.centerIn: parent
                cellHeight: items.cardSize
                cellWidth: items.cardSize
                model: cardListModel
                delegate: Card {

                }
            }
        }

        Rectangle {
            id: activityArea
            parent: layoutArea
            height: parent.height
            width: parent.width * 0.65
            anchors.left: numberContainer.right

            Rectangle {
                id: topContainer
                height: parent.height * 0.4
                width: parent.width * 0.5
                border.color: "black"
                border.width: 3
                radius: 15
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: 10
                }
                color: "#F0CB38"
            }
            Rectangle {
                id: bottomContainer
                height: parent.height * 0.4
                width: parent.width * 0.5
                border.color: "black"
                border.width: 3
                radius: 15
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: topContainer.bottom
                    topMargin: 10
                }
                color: "#F0CB38"
            }
        }

        Container {
            parent: layoutArea
            height: 100
            width: 100
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
