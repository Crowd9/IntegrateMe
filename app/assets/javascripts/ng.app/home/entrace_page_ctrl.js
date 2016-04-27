angular.module("demo.home").controller("EntrancePageCtrl", ["$rootScope", "$scope", "$location", "$timeout", "$routeParams", "Competition", "Entry", "Setting", function($rootScope, $scope, $location, $timeout, $routeParams, Competition, Entry, Setting) {

  var mailchimpSetting = Setting.mailchimpSetting();
  if (!mailchimpSetting || !mailchimpSetting.id) {
    var search = {};
    search.next = $location.path();

    $timeout(function() {
      $location.path("/settings/mailchimp_api").search(search);
    });

    return;
  }

  var loadCompetition = function() {
    $scope.isLoadingCompetition = true;
    Competition.loadCompetition($routeParams.competition_id, {}, function(respondData) {
      $scope.competition = respondData.results;
      $scope.isLoadingCompetition = false;
    }, function(data) {
      $scope.isLoadingCompetition = false;
      var errors = $scope.errorsOf(data);
      $location.path("/");
    });
  }

  $scope.submit = function() {
    if ($scope.isSubmitting) {
      return;
    }

    if ($scope.entryForm.$valid) {
      $scope.entry.competition_id = $routeParams.competition_id;
      $scope.isSubmitting = true;

      Entry.create($scope.entry, function(respondData) {
        $scope.isEntrySaved = true;
        $scope.isSubmitting = false;
      }, function(data) {
        $scope.isSubmitting = false;
        $scope.errors = $scope.errorsOf(data);
        alert("Failed to add entry");
      });
    } else {
      $scope.isSubmitted = true;
    }
  }

  loadCompetition();
}]);
