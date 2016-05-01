angular.module('integrate', []).controller('EntrantController', ($scope, $http) ->
  self = @

  @init = (data) ->
    self.competition = data.competition
    self.entry = {
      campaign_id: data.campaign_id, 
      competition_id: data.competition.id,
      name: data.competition.entry_name,
      email: data.competition.entry_email,
      id: data.entry_id
    }

  @submit = ->
    $http.post("/entries", self.entry).
      success((data, status, headers, config) ->
        if data.success
          self.entry.completed = true
        else
          self.errors = data.errors
      ).
      error((data, status, headers, config) ->
        alert("ERROR!")
      )

  @update = ->
    $http.put("/campaigns/"+self.entry.campaign_id+"/entries/"+ self.entry.id, self.entry).
    success((data, status, headers, config) ->
      if data.success
        self.entry.completed = true
      else
        self.errors = data.errors
    ).
    error((data, status, headers, config) ->
      alert("ERROR!")
    )

  self
)
