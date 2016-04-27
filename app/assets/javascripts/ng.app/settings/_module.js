angular.module('demo.settings', [])
.config(["$routeProvider", function($routeProvider) {
  $routeProvider.when("/settings", {
    templateUrl: "settings/templates/index.html",
    controller: "SettingsCtrl"
  })
  .when("/settings/:code", {
    templateUrl: "settings/templates/mailchimp_api_form.html",
    controller: "SettingFormCtrl"
  });
}])
.run(["$rootScope", function($rootScope) {
  $rootScope.settingCodes = window.App.settingCodes;
}]);
