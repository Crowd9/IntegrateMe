angular.module("demo.settings").controller("SettingsCtrl", ["$rootScope", "$scope", "$location", "$routeParams", "Setting", function($rootScope, $scope, $location, $routeParams, Setting) {

  var loadSettings = function() {
    $scope.isLoadingSettings = true;
    Setting.allSettings({}, function(respondData) {
      $scope.settings = respondData.results;
      if ($scope.settings && $scope.settings.length > 0) {
        $scope.settingGroups = {};
        angular.forEach($scope.settings, function(setting) {
          $scope.settingGroups[setting.code] = $scope.settingGroups[setting.code] || [];
          $scope.settingGroups[setting.code].push(setting);
        });
      }
      $scope.isLoadingSettings = false;
    }, function(data) {
      $scope.isLoadingSettings = false;
    });
  };

  loadSettings();
}]);
