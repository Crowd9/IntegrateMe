angular.module('demo.utils').directive('customPagination', [function() {
  return {
    restrict: 'A',
    scope: {
      paging: "=",
      goToPage: "="
    },
    templateUrl: "utils/templates/pagination-directive.html",
    link: function(scope, ele, attrs) {

      var paginate = function() {
        var start = scope.paging.currentPage - 2;

        if (scope.paging.minPage === null || scope.paging.minPage === undefined) {
          scope.paging.minPage = 1;
        }
        if (scope.paging.maxPage === null || scope.paging.maxPage === undefined) {
          scope.paging.maxPage = scope.paging.totalPages;
        }

        if (start <= 0) {
          start = scope.paging.minPage;
        }

        var end = start + 4;

        if (end > scope.paging.maxPage) {
          end = scope.paging.maxPage;
        }

        start = end - 4;

        if (start <= 0) {
          start = scope.paging.minPage;
        }

        scope.paging.pages = [];
        for (var i = start; i <= end; i++) {
          var label = scope.paging.minPage == 0 ? i + 1 : i;
          scope.paging.pages.push({number: i, label: label});
        }

        scope.paging.showFirstPage = start > scope.paging.minPage;
        scope.paging.showFirstDots = start > scope.paging.minPage + 1;
        scope.paging.showLastPage = end < scope.paging.maxPage;
        scope.paging.showLastDots = end + 1 < scope.paging.maxPage;
      }

      scope.$watch("paging", function() {
        if (scope.paging) {
          paginate();
        }
      }, true);
    }
  }
}])
