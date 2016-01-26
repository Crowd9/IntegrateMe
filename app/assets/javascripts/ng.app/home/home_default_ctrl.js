angular.module("demo.home").controller("HomeDefaultCtrl", ["$rootScope", "$scope", "$location", "Competition", function($rootScope, $scope, $location, Competition) {

  var perPage = 20;
  var loadCompetitions = function(page, per_page) {
    var params = {}
    params.per_page = per_page || perPage;
    params.page = page || 1;

    $scope.isLoading = true;
    Competition.allCompetitions(params, function(respondData) {
      $scope.competitions = respondData.results;
      $scope.competitionsPaging = $rootScope.getPaginationInfo(respondData);
      $scope.isLoading = false;

      if (!$scope.competitions || $scope.competitions.length == 0) {
        alert("No competitions found, please seed database first");
      }
    }, function(data) {
      $scope.isLoading = false;
      var errors = $scope.errorsOf(data);
      console.log("Errors loading competitions", errors);
    });
  }

  loadCompetitions();
}]);
