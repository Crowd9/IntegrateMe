angular.module("demo.settings").controller("SettingFormCtrl", ["$rootScope", "$scope", "$location", "$routeParams", "Setting", function($rootScope, $scope, $location, $routeParams, Setting) {

  var loadSetting = function() {
    var params = {};

    params["search[code]"] = $routeParams.code;
    Setting.allSettings(params, function(respondData) {
      $scope.setting = respondData.results && respondData.results[0] || {};
    });
  }

  $scope.saveSetting = function() {
    if ($scope.isSubmitting) {
      return;
    }

    if ($scope.settingForm.$valid) {
      $scope.setting.code = $routeParams.code;
      Setting.create($scope.setting, function(respondData) {
        Setting.cacheMailchimpSettings(respondData.results);

        var searchParams = $location.search();
        var next = searchParams.next;
        delete searchParams.next;

        $location.path(next || "/settings").search(searchParams);
        $scope.isSubmitting = false;
      }, function(data) {
        $scope.isSubmitting = false;
        $scope.errors = $scope.errorsOf(data);
        console.log("Error saving setting", $scope.errors);
        alert("Saving setting failed");
      });
    } else {
      $scope.isSubmitted = true;
    }
  }

  loadSetting();
}]);
