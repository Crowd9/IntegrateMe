angular.module("demo.home").factory("Competition", ["$q", "Util", function($q, Util) {
  var service = {};

  service.allCompetitions = function(params, successCallback, errorCallback) {
    var url = Routes.api_v1_competitions_path();
    return Util.submitRequest(url, "get", params, successCallback, errorCallback);
  };

  service.loadCompetition = function(id, params, successCallback, errorCallback) {
    var url = Routes.api_v1_competition_path(id);
    return Util.submitRequest(url, "get", params, successCallback, errorCallback);
  }

  return service;
}]);
