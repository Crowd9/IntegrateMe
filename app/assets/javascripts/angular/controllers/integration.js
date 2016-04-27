var integrationControllers = angular.module('integrationControllers', []);

integrationControllers.controller('IntegrationListCtrl', ['$scope', 'Integration', function($scope, Integration) {
  $scope.integrations = Integration.query();
}]);

integrationControllers.controller('IntegrationEditCtrl', ['$scope', '$routeParams', '$sce', 'Integration', function($scope, $routeParams, $sce, Integration) {
  $scope.integrations = Integration.query();
  $scope.integration = Integration.get({id: $routeParams.id}, function(integration) {
    $scope.currentIntegration = integration.id;
  });
  $scope.trustSrc = function(src) {
    return $sce.trustAsResourceUrl('/integrations/' + src);
  }
}]);
