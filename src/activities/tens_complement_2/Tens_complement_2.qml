/* GCompris - tens_complement_2.qml
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12

import GCompris 1.0
import "../../core"
import "tens_complement_2.js" as Activity
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
            property alias firstCardListModel: firstCardListModel
            property alias secondCardListModel: secondCardListModel
            property alias thirdCardListModel: thirdCardListModel
            readonly property var levels: activity.datasetLoader.data
            property int numberOfCards: 18
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
            id: firstCardListModel
        }

        ListModel {
            id: secondCardListModel
        }

        ListModel {
            id: thirdCardListModel
        }

        Rectangle {
            id: containerHolder
            parent: layoutArea
            height: layoutArea.height * 0.7
            width: layoutArea.width * 0.5
            color: "white"
            radius: 20
            anchors.centerIn: parent

            CardContainer {
                id: firstCardListContainer
                height: parent.height / 4;
                width: parent.width
                anchors.top: parent.top
                listmodel: firstCardListModel
                numberOfCards: items.numberOfCards
            }

            CardContainer {
                id: secondCardListContainer
                height: parent.height / 4;
                width: parent.width
                anchors.top: firstCardListContainer.bottom
                anchors.topMargin: firstCardListContainer.height / 3
                listmodel: secondCardListModel
                numberOfCards: items.numberOfCards
            }

            CardContainer {
                id: thirdCardListContainer
                height: parent.height / 4;
                width: parent.width
                anchors.top: secondCardListContainer.bottom
                anchors.topMargin: firstCardListContainer.height / 3
                listmodel: thirdCardListModel
                numberOfCards: items.numberOfCards
            }
        }

        Score {
            id: score
            parent: layoutArea
            color: "black"
        }

        BarButton {
            id: okButton
            parent: layoutArea
            height: firstCardListContainer.height * 0.9
            width: firstCardListContainer.height * 0.9
            z: 2
            source: "qrc:/gcompris/src/core/resource/bar_ok.svg"
            anchors {
                horizontalCenter: layoutArea.horizontalCenter
                bottom: parent.bottom
            }
            enabled: !bonus.isPlaying
            onClicked: Activity.checkAnswer()
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

        DialogHelp {
            id: dialogHelp
            onClose: home()
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
