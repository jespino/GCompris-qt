/* GCompris - comparator.qml
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.9

import "../../core"
import "comparator.js" as Activity

ActivityBase {
    id: activity

    onStart: focus = true
    onStop: {}

    pageComponent: Rectangle {
        id: background
        anchors.fill: parent
        color: "#ABCDEF"
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
            property var levels: activity.datasetLoader.data
        }

        onStart: { Activity.start(items) }
        onStop: { Activity.stop() }

        GCText {
            anchors.centerIn: parent
            text: "comparator activity"
            fontSize: largeSize
        }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Item {
            id: layoutArea
            anchors {
                top: topPanel.bottom
                left: parent.left
                right: parent.right
                bottom: bar.top
                bottomMargin: bar.height * 0.2
            }
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
