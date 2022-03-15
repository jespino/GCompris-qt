/* GCompris - Comparator.qml
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 * Authors:
 *   Aastha Chauhan <aastha.chauhan01@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.9
import QtQuick.Controls 2.15

import "../../core"
import "comparator.js" as Activity

ActivityBase {
    id: activity

    onStart: focus = true
    onStop: {}

    pageComponent: Image{
        id: background
        source: "qrc:/gcompris/src/activities/checkers/resource/background-wood.svg"
        anchors.centerIn: parent
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        sourceSize.height: height
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
            text: ""
            fontSize: largeSize
        }

            Row{

            spacing: 50
            x:800
            y:400

            BarButton {

            id: up
            height: 130
            width: 130
            source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
            rotation: -90
            Rectangle {
                anchors.fill: parent
                radius: width * 0.5
                color: "white"
                border.color: "black"
                border.width: 4
                opacity: 0.2

                       }
                    }


        BarButton {

            id: down
            height: 130
            width: 130
            source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
            rotation: +90
            Rectangle {
                anchors.fill: parent
                radius: width * 0.5
                color: "white"
                border.color: "black"
                border.width: 4
                opacity: 0.2

                      }
                  }
            }


         Row{

            spacing: 50
            x:740
            y:700

            BarButton {

            id: lessThan
            height: 100
            width: 100
            source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
            rotation: -90
            Rectangle   {
                anchors.fill: parent
                radius: width * 0.5
                color: "#00FFFFFF"
                border.color: "#F2F2F2"
                border.width: 4

                        }
                     }

        BarButton {

            id: equal
            height: 100
            width: 100
            source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
            rotation: +90
            Rectangle {
                anchors.fill: parent
                radius: width * 0.5
                color: "#00FFFFFF"
                border.color: "#F2F2F2"
                border.width: 4

                      }
                  }

            BarButton {

            id: greaterThan
            height: 100
            width: 100
            source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
            rotation: +180
            Rectangle {
                anchors.fill: parent
                radius: width * 0.5
                color: "#00FFFFFF"
                border.color: "#F2F2F2"
                border.width: 4

                       }

                    }
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
