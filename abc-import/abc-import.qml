//=============================================================================
//
//  ABC Import Plugin
//  Based on ABC Import by Nicolas Froment (lasconic)
//  Copyright (2013) Stephane Groleau (vgstef)
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//=============================================================================

import QtQuick 2.4
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import MuseScore 1.0
import FileIO 1.0

import "abc-import.js" as Abc;

MuseScore {
    menuPath: "Plugins.ABC-Import"
    version: "0.1"
    description: qsTr("This plugin imports ABC text from a file or the clipboard.")
    pluginType: "dialog"

    id:window
    width:  800; height: 500;

    FileIO {
        id: myFileAbc
        onError: console.log(msg + "  Filename = " + myFileAbc.source)
    }

    FileDialog {
        id: fileDialog
        title: qsTr("Please choose a file")
        folder: "file:///home/gawain/workspace/java/ABC/abc-import/"
        onAccepted: {
            var filename = fileDialog.fileUrl

            if(filename) {
                myFileAbc.source = filename
                abcText.text = myFileAbc.read()
            }
            else {
                myFileAbc.source = "file:///home/gawain/workspace/java/ABC/abc-import/Repertoire_15.abc"
                abcText.text = myFileAbc.read()
            }
        }
    }

    Label {
        id: textLabel
        wrapMode: Text.WordWrap
        text: qsTr("Paste your ABC tune here (or click button to load a file)")
        font.pointSize:12
        anchors.left: window.left
        anchors.top: window.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
    }

    // Where people can paste their ABC tune or where an ABC file is put when opened
    TextArea {
        id:abcText
        anchors.top: textLabel.bottom
        anchors.left: window.left
        anchors.right: window.right
        anchors.bottom: buttonOpenFile.top
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        width:parent.width
        height:400
        wrapMode: TextEdit.WrapAnywhere
        textFormat: TextEdit.PlainText
    }

    Button {
        id : buttonOpenFile
        text: qsTr("Open file")
        anchors.bottom: window.bottom
        anchors.left: abcText.left
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        onClicked: {
            fileDialog.open();
        }
    }

    Button {
        id : buttonConvert
        text: qsTr("Import")
        anchors.bottom: window.bottom
        anchors.right: abcText.right
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        onClicked: {
            var input = abcText.text
            var tree = Abc.getTree(input);

//Abc.antlr4.tree.ParseTreeWalker.DEFAULT.walk(printer, tree);
console.log("/-----");
        }
    }

    Button {
        id : buttonCancel
        text: qsTr("Cancel")
        anchors.bottom: window.bottom
        anchors.right: buttonConvert.left
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        onClicked: {
            Qt.quit();
        }
    }
}
