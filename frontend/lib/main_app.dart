// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:http/browser_client.dart' as browser_client;

import 'package:polymer/polymer.dart';

import 'package:godart_v1_api/greeting/v1.dart';

/// A Polymer `<main-app>` element.
@CustomTag('main-app')
class MainApp extends PolymerElement {
  GreetingApi api;
  @observable int total = 0;
  @observable String comment = '';
  @observable GreetingsList greetings;

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  void addComment(Event event, Object object, Node sender) {
    Greeting greeting = new Greeting()
      ..author = "David Cruz"
      ..content = this.comment;
    api.greets.add(greeting).then((data) => print("added"));
  }

  void listComments() {
    api.greets.list(limit: 10).then((GreetingsList greetings) {
      if (greetings.items != null) {
        this.greetings = greetings;
      }
    });
  }

  void countComments() {
    api.greets.count().then((total) => this.total = total.count);
  }

// Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
//  attached() {
//    super.attached();
//  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanges(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
  ready() {
    super.ready();
    api = new GreetingApi(new browser_client.BrowserClient());

    listComments();
    countComments();
  }
}
