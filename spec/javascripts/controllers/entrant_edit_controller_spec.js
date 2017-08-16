(function(){
  'use strict';
  var scope, httpBackend, createController;

  beforeEach(function() {
      module('integrate');
    });

  describe('Controller: EditController', function () {

    beforeEach(inject(function($rootScope, $httpBackend, $controller) {
        httpBackend = $httpBackend;
        scope = $rootScope.$new();

        createController = function() {
            return $controller('EditController', {
                '$scope': scope
            });
        };
    }));

    afterEach(function() {
        httpBackend.verifyNoOutstandingExpectation();
        httpBackend.verifyNoOutstandingRequest();
    });

    it('should run the submitKey method to get lists from backend', function() {
        var controller = createController();
        scope.competitionId = 1;
        controller.api_key = '89f98d2f062c17ddb5b9414c23d72011-us16';

        httpBackend.expect('GET', '/api/v1/competitions/' + scope.competitionId + '/mailchimp_lists?api_key=89f98d2f062c17ddb5b9414c23d72011-us16')
            .respond({
                "success": true,
                "data": {"lists": [{id: 1, name: 'List1'}, {id: 2, name: 'List2'}]}
            });

        scope.$apply(function() {
          controller.submitKey(scope.competitionId);
        });

        httpBackend.flush();

        expect(controller.lists).toEqual([{id: 1, name: 'List1'}, {id: 2, name: 'List2'}]);

    });

    it('should run the saveList method and save lists', function() {
        var controller = createController();
        scope.competitionId = 2;
        controller.api_key = '89f98d2f062c17ddb5b9414c23d72011-us16';
        controller.selected_list = {
            id: 5,
            name: 'List2'
        }
        controller.assign_to_list = false;
        httpBackend.expect('POST', "/api/v1/competitions/" + scope.competitionId + "/subscribe_to_mailchimp_list", {api_key : controller.api_key, list_id: controller.selected_list.id, assign_all_emails_to_list: controller.assign_to_list})
          .respond({
            "success": true,
            "status": 200
          });

        scope.$apply(function() {
          controller.saveList(scope.competitionId);
        });

        httpBackend.flush();
        
    });

  });

})();