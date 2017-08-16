angular
  .module('integrate')
  .controller('EditController', ($scope, $http) ->
    self = @

    self.api_key = ''
    self.selected_list = ''
    self.assign_to_list = false;
    self.show_lists = false

    @submitKey = (competitionId) ->
      $http.get("/api/v1/competitions/" + competitionId + "/mailchimp_lists?api_key=" + self.api_key).
        success((res, status, headers, config) ->
          if res.success
            self.errors = '';
            self.show_lists = true
            self.lists = res.data.lists
          else
            self.errors = res.errors
            
        ).
        error((data, status, headers, config) ->
          alert(data)
        )

    @saveList = (competitionId) ->
      $http.post("/api/v1/competitions/" + competitionId + "/subscribe_to_mailchimp_list", {api_key : self.api_key, list_id: self.selected_list.id, assign_all_emails_to_list: self.assign_to_list}).
        success((res, status, headers, config) ->
          if res.success
            
          else
            
        ).
        error((data, status, headers, config) ->
          alert(data)
        )


    self
)
