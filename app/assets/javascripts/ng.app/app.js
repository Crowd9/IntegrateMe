angular.module("demo", ["ngRoute", "ngSanitize", "demo.templates", "demo.utils", "demo.settings", "demo.home"])
.config(["$routeProvider", "$locationProvider", function($routeProvider, $locationProvider) {
  $routeProvider.otherwise({
    redirectTo: function() {
      return "/";
    }
  });
  $locationProvider.html5Mode(true).hashPrefix("!");
}])
.config(["$httpProvider", function($httpProvider) {
  headers = $httpProvider.defaults.headers.common;
  headers["Accept"] = "application/json";
  headers['X-Requested-With'] = 'XMLHttpRequest';

  token = document.querySelector("meta[name='csrf-token']").content;
  if (token) {
    headers['X-CSRF-TOKEN'] = token;
  }
}])
.run(["$rootScope", "$filter", function($rootScope, $filter) {
  $rootScope.errorsOf = function(data) {
    if (data) {
      if (data.errors) {
        return data.errors;
      } else if (data.error || data.message) {
        return data.message || data.error;
      } else {
        return "Internal error";
      }
    } else {
      return "Unknown error";
    }
  };

  $rootScope.formatDate = function(date, format) {
    var dateFilter = $filter("date");

    return dateFilter(date, format);
  };

  $rootScope.getPaginationInfo = function(respondData) {
    if (respondData.pagination) {
      return {
        total: respondData.pagination.count,
        perPage: respondData.pagination.per_page,
        currentPage: respondData.pagination.current_page,
        totalPages: respondData.pagination.total_pages,
        minPage: 1,
        maxPage: respondData.pagination.total_pages
      };
    }
  };
}]);
