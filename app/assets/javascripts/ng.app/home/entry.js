angular.module("demo.home").factory("Entry", ["Util", function(Util) {
  var service = {};

  service.create = function(params, successCallback, errorCallback) {
    var url = Routes.api_v1_entries_path();
    return Util.submitRequest(url, "post", {data: {entry: params}}, successCallback, errorCallback);
  }

  return service;
}]);
