/*-
 * Copyright (c) 2014 Peter Tworek
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the author nor the names of any co-contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

import QtQuick 2.2
import Sailfish.Silica 1.0
import BerlinVegan.components 1.0 as BVApp

Page {
    property string licenseFile: ""
    property string licenseName: ""

    Component.onCompleted: {
        var json
        var xhr = new XMLHttpRequest();
        xhr.open("GET", licenseFile)
        xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE)
                {
                    licenseText.text = xhr.responseText
                    licenseText.text = licenseText.text.replace(/(\r\n|\n|\r){2}/gm,"micuParagraph")
                    licenseText.text = licenseText.text.replace(/ *(\r\n|\n|\r) */gm," ")
                    licenseText.text = licenseText.text.replace(/(micuParagraph)/gm,"\n\n")

                    licenseText.text = licenseText.text.trim()
                }
        }

        xhr.send();
    }

    SilicaFlickable {
        anchors.fill: parent
        anchors.leftMargin: BVApp.Theme.paddingMedium
        anchors.rightMargin: BVApp.Theme.paddingMedium
        contentHeight: column.height

        Column {
            id: column
            width: parent.width

            PageHeader {
                //% "License:"
                title: qsTrId("id-license") + " " + licenseName
            }

            Text {
                id: licenseText
                width: parent.width
                font.pixelSize: BVApp.Theme.fontSizeExtraSmall
                color: BVApp.Theme.secondaryColor
                wrapMode: Text.WordWrap
            }
        }

        VerticalScrollDecorator {}
    }
}
