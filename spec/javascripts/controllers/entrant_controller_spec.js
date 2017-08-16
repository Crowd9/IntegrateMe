(function(){
  'use strict';
  var scope, httpBackend, createController;

  beforeEach(function() {
      module('integrate');
    });

  describe('Controller: EntrantController', function () {

    beforeEach(inject(function($rootScope, $httpBackend, $controller) {
        httpBackend = $httpBackend;
        scope = $rootScope.$new();

        createController = function() {
            return $controller('EntrantController', {
                '$scope': scope
            });
        };
    }));

    afterEach(function() {
        httpBackend.verifyNoOutstandingExpectation();
        httpBackend.verifyNoOutstandingRequest();
    });

    it('should run the init method to get the competition data from the backend', function() {
        var controller = createController();
        scope.competitionId = 1;

        httpBackend.expect('GET', '/api/v1/competitions/1')
            .respond({
                "success": true,
                "data": {id: 1, name: 'Some name'}
            });

        scope.$apply(function() {
          controller.init(1);
        });

        httpBackend.flush();

        expect(controller.competition).toEqual({id: 1, name: 'Some name'});

    });

    it('should run the submit method to set entries', function() {
        var controller = createController();
        controller.entry = {
          "competition_id":2,
          "email":"someemail@gmail.com"
        }

        httpBackend.expect('POST', '/api/v1/entries', controller.entry)
          .respond({
            "success": true,
            "status": 200
          });

        scope.$apply(function() {
          controller.submit();
        });

        httpBackend.flush();

        expect(controller.entry.completed).toEqual(true);
        
    });

  });

})();