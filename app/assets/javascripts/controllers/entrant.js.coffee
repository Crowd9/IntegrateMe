angular.module('integrate', []).controller('EntrantController', ($scope, $http) ->
  self = @

  @init = (dataId) ->
    $http.get("/api/v1/competitions/" + dataId).
      success((res, status, headers, config) ->
        self.competition = res.data
        self.entry = competition_id: res.data.id
      ).
      error((data, status, headers, config) ->
        alert(data)
      )


  @submit = ->
    $http.post("/api/v1/entries", self.entry).
      success((data, status, headers, config) ->

        if data.success
          self.entry.completed = true
        else
          self.errors = data.errors

      ).
      error((data, status, headers, config) ->
        alert(data)
      )

  self
)
