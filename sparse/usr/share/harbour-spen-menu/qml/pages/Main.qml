/*
    Copyright (C) edp17 (Miklos Csekk) <edp17@pm.me>
    All rights reserved.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Process 1.0

Page {
    id: page

    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height + header.height + Theme.paddingLarge

        PageHeader {
            id: header
            title: qsTr("SPen-Apps")
        }

        Column {
            id: column
            spacing: Theme.paddingLarge
            anchors.top: parent.top
            anchors.topMargin: header.height
            width: parent.width

            Text {
                text: qsTr("This app is started by pulling out the S-Pen. Starting any application can be added here or specific apps developed for S-Pen only. This app closes when the S-Pen is plugged back in. All apps started from here will remain open/running.")
                color: "white"
                textFormat: Text.StyledText
                font.pixelSize: Theme.fontSizeSmall
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - Theme.paddingLarge*2
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.AlignHCenter
                linkColor: Theme.highlightColor

            }

//=====About=========================================================
            Separator {
                width: parent.width
                color: Theme.primaryColor
                horizontalAlignment: Qt.AlignHCenter
            }

            SectionHeader {
                text: "About"
            }

Button {
            Text {
                text: qsTr("About this app")
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeSmall
                linkColor: Theme.highlightColor
                anchors.horizontalCenter: parent.horizontalCenter
                onLinkActivated: Qt.openUrlExternally(link)
                color: "white"
                textFormat: Text.StyledText
            }
                onClicked: pageStack.push("About.qml")
            }
            
            Separator {
                width: parent.width
                color: Theme.primaryColor
                horizontalAlignment: Qt.AlignHCenter
            }

       }
        Process {
            id: process
            onReadyRead: text.text = readAll();
        }
       VerticalScrollDecorator {}
    }
}
