angular.module('integrate').controller('EntrantController', ($scope, $http) ->
  self = @

  @init = (data) ->
    self.competition = data.competition
    self.entry = { competition_id: data.competition.id }

  @submit = ->
    $http.post("/api/entries", self.entry).
      success((data, status, headers, config) ->
        self.entry.completed = true
      ).
      error((data, status, headers, config) ->
        if data.errors
          self.errors = data.errors
        else
          alert("SERVER ERROR: #{status}")
      )

  self
)
