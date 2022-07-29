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
            property alias questionListModel: questionListModel
            property alias answerListModel: answerListModel
            property alias questionListModel2: questionListModel2
            property alias answerListModel2: answerListModel2
            readonly property var levels: activity.datasetLoader.data
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

        ListModel {
            id: questionListModel
        }

        ListModel {
            id: answerListModel
        }

        ListModel {
            id: questionListModel2
        }

        ListModel {
            id: answerListModel2
        }

        Rectangle {
            id: activityArea
            parent: layoutArea
            height: parent.height
            width: parent.width * 0.65
            anchors.left: numberContainer.right

            ContainerBox {
                id: topContainer
                height: parent.height * 0.4
                width: parent.width * 0.7
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: 10
                }
                questionListModel: questionListModel
                answerListModel: answerListModel
            }

            ContainerBox {
                id: bottomContainer
                height: parent.height * 0.4
                width: parent.width * 0.7
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: topContainer.bottom
                    topMargin: 10
                }
                questionListModel: questionListModel2
                answerListModel: answerListModel2
            }
        }

        BarButton {
            id: okButton
            parent: activityArea
            z: 2
            source: "qrc:/gcompris/src/core/resource/bar_ok.svg"
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            sourceSize.height: 100
            sourceSize.width: 100
            height: sourceSize.height
            width: sourceSize.width
            onClicked: {
                console.log("clicked")
            }
        }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        DialogChooseLevel {
            id: dialogActivityConfig
            currentActivity: activity.activityInfo

            onSaveData: {
                levelFolder = dialogActivityConfig.chosenLevels
                currentActivity.currentLevels = dialogActivityConfig.chosenLevels
                ApplicationSettings.setCurrentLevels(currentActivity.name, dialogActivityConfig.chosenLevels)
                // restart activity on saving
                background.start()
            }
            onClose: {
                home()
            }
            onStartActivity: {
                background.start()
            }
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level | activityConfig }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
            onActivityConfigClicked: {
                displayDialog(dialogActivityConfig)
            }
        }

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }
    }

}
