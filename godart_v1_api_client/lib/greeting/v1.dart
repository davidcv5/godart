// This is a generated file (see the discoveryapis_generator project).

library godart_v1_api.greeting.v1;

import 'dart:core' as core;
import 'dart:collection' as collection;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client greeting/v1';

/** Greetings API */
class GreetingApi {

  final commons.ApiRequester _requester;

  GreetsResourceApi get greets => new GreetsResourceApi(_requester);

  GreetingApi(http.Client client, {core.String rootUrl: "http://localhost:8080/_ah/api/", core.String servicePath: "greeting/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class GreetsResourceApi {
  final commons.ApiRequester _requester;

  GreetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Add a greeting.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future add(Greeting request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _downloadOptions = null;

    _url = 'greetings';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Count all greetings.
   *
   * Request parameters:
   *
   * Completes with a [Count].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<Count> count() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'greetings/count';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Count.fromJson(data));
  }

  /**
   * List most recent greetings.
   *
   * Request parameters:
   *
   * [limit] - null
   *
   * Completes with a [GreetingsList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<GreetingsList> list({core.int limit}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (limit != null) {
      _queryParams["limit"] = ["${limit}"];
    }

    _url = 'greetings';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GreetingsList.fromJson(data));
  }

}



class Count {
  core.int count;

  Count();

  Count.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    return _json;
  }
}

class Greeting {
  core.String author;
  core.String content;
  core.DateTime date;
  core.String id;

  Greeting();

  Greeting.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = _json["author"];
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("date")) {
      date = core.DateTime.parse(_json["date"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = author;
    }
    if (content != null) {
      _json["content"] = content;
    }
    if (date != null) {
      _json["date"] = (date).toIso8601String();
    }
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

class GreetingsList {
  core.List<Greeting> items;

  GreetingsList();

  GreetingsList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Greeting.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
