
var integrationServices = angular.module('integrationServices', ['ngResource']);

integrationServices.factory('Integration', ['$resource',
  function($resource){
    return $resource('/integrations/:id.json');
  }]);
