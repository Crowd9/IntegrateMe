angular.module("demo.settings").factory("Setting", ["$q", "Util", function($q, Util) {
  var service = {};

  service.allSettings = function(params, successCallback, errorCallback) {
    var url = Routes.api_v1_settings_path();
    return Util.submitRequest(url, "get", params, successCallback, errorCallback);
  };

  service.create = function(params, successCallback, errorCallback) {
    var url = Routes.api_v1_settings_path();
    return Util.submitRequest(url, "post", {data: {setting: params}}, successCallback, errorCallback);
  }

  service.mailchimpSetting = function(force, successCallback, errorCallback) {
    if (typeof(force) == "function") {
      errorCallback = successCallback;
      successCallback = force;
      force = false;
    }

    if (service.__mailchimp_settings__ && !force) {
      if (successCallback) {
        successCallback(service.__mailchimp_settings__);
      }

      return service.__mailchimp_settings__;
    }

    var ret = $q.defer();
    var params = {};
    params["search[code]"] == "mailchimp_api";
    service.allSettings(params, function(respondData) {
      var result;
      if (respondData.results && respondData.results.length > 0) {
        result = respondData.results[0];
      } else {
        result = {};
      }

      service.cacheMailchimpSettings(result);
      if (successCallback) {
        successCallback(result);
      }

      ret.resolve(result);
    }, function(error, status, headers, config) {
      if (errorCallback) {
        errorCallback(error, status, headers, config)
      }

      ret.reject();
    });

    return ret.promise;
  };

  service.cacheMailchimpSettings = function(setting) {
    service.__mailchimp_settings__ = setting;
  }

  return service;
}]);
