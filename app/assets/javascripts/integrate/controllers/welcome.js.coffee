angular.module('integrate').controller('WelcomeController', ($scope, $http) ->
  self = @

  @init = (data) ->
    self.competitions = data.competitions
    self.new_competition = { name: '', requires_entry_name: true }
    self.mail_chimp_lists = null

  @fetchLists = () ->
    self.new_competition.mail_chimp_list_id = null
    self.mail_chimp_lists = null
    mail_chimp_api_key = self.new_competition.mail_chimp_api_key
    $http.get("/api/mail_chimp/lists?mail_chimp_api_key=#{mail_chimp_api_key}").
      success((data) ->
        self.mail_chimp_lists = data.lists
      ).
      error((data, status) ->
        if (data.error_message)
          alert("FETCH ERROR: #{data.error_message}")
        else
          alert("SERVER ERROR: #{status}")
      )
    self.mail_chimp_lists

  @create_competition = () ->
    self.errors = null
    $http.post("/api/competitions", { competition: self.new_competition }).
      success((data, status, headers, config) ->
        self.competitions.unshift(data);
        self.new_competition = {}
        self.mail_chimp_lists = null;
      ).
      error((data, status, headers, config) ->
        if data.errors
          self.errors = data.errors
        else
          alert("SERVER ERROR: #{status}")
      )

  self
)
