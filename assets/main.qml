/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2

Page {
    titleBar: [
        TitleBar {
            title: "Lucky Lloyd's Number Generator"
        }
    ]
    Menu.definition: MenuDefinition {
        actions: [
            ActionItem {
                title: "Settings"
                enabled: true
                onTriggered: {
                    settings.open()
                } 
            }]}
    ScrollView {
        Container {
            id: main
            function getRand(num){
                var randnum ='';
                for (var i=0;i < num;i++){
                    randnum += Math.floor(Math.random()*10)
                }
                return randnum;
            }
            Header {
                title: "Select the number of digits to generate:"
            }
            Label {
                id: slabel
                text: Math.floor(slider.value)+" Digits"
                horizontalAlignment: HorizontalAlignment.Center
            }
            Slider {
                id: slider
                value: _app.getValueFor("slider.value", 6.0)
                fromValue: _app.getValueFor("slider.fromValue", 1.0)
                toValue: _app.getValueFor("slider.toValue", 100.0)
                onImmediateValueChanged: {
                    slabel.text=Math.floor(immediateValue)+" Digits"
                    result.text= main.getRand(Math.floor(slider.immediateValue))
                    _app.saveValueFor("slider.value", Math.floor(immediateValue))
                }
                horizontalAlignment: HorizontalAlignment.Fill
            }
            Button {
                text: "Shuffle Numbers"
                onClicked: {
                    result.text= main.getRand(Math.floor(slider.value));
                }
                horizontalAlignment: HorizontalAlignment.Center
            }
            TextArea {
                id: result
                text: main.getRand(Math.floor(slider.value))
                horizontalAlignment: HorizontalAlignment.Center
            }
            attachedObjects: [
                Sheet {
                    id: settings
                    peekEnabled: false
                    content: [
                        Page {
                            titleBar: TitleBar {
                                title: "Settings"
                                dismissAction: ActionItem {
                                    id: cancelButton
                                    title: "Back"
                                    onTriggered: {
                                        settings.close()
                                    }
                                }
                            }
                            Container {
                                Header {
                                    id: maxvaluelabel
                                    title: "Max Slider Value: "+maxvalue.value
                                }
                                Slider {
                                    id: maxvalue
                                    value: _app.getValueFor("slider.toValue", 100.0)
                                    fromValue: 100
                                    toValue: 700
                                    onImmediateValueChanged: {
                                        maxvaluelabel.title = "Max Slider Value: "+Math.floor(immediateValue)
                                        _app.saveValueFor("slider.toValue", Math.floor(immediateValue))
                                        slider.toValue = Math.floor(immediateValue)
                                    }
                                }
                                Header {
                                    title: "Restore Defaults"
                                }
                                Button {
                                    id: defaults
                                    text: "Default Settings"
                                    onClicked: {
                                        _app.clearSettings("clear")
                                        slider.value = 6
                                        slider.fromValue = 1
                                        slider.toValue = 100
                                        maxvalue.value = 100
                                    }
                                }
                            }
                        }
                    ]
                }
            ]
        }
    }
}
