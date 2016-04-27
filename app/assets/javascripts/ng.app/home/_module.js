angular.module('demo.home', [])
.config(["$routeProvider", function($routeProvider) {
  $routeProvider.when("/", {
    templateUrl: "home/templates/default.html",
    controller: "HomeDefaultCtrl"
  })
  .when("/competitions/:competition_id/entries/new", {
    templateUrl: "home/templates/entrance_page.html",
    controller: "EntrancePageCtrl",
    resolve: {
      mailchimpSetting: function(Setting) {
        return Setting.mailchimpSetting();
      }
    }
  });
}]);
