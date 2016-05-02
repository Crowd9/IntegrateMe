angular.module('integrate').controller('CampaignsController', ($scope, $http) ->
  self = @

  @init = (data) ->
    self.campaign = data.campaign

  @action = ->
    if self.campaign.action == 'Create'
      self.submit()
    else
      self.update()
  
  @submit = ->
    $http.post("/campaigns", self.campaign).
    success((data, status, headers, config) ->
      if data.success
        self.campaign.completed = true
      else
        self.errors = data.errors
    ).
    error((data, status, headers, config) ->
      alert("ERROR!")
    )

  @update = ->
    $http.patch("/campaigns/"+self.campaign.id, self.campaign).
    success((data, status, headers, config) ->
      if data.success
        self.campaign.completed = true
      else
        self.errors = data.errors
    ).
    error((data, status, headers, config) ->
      alert("ERROR!")
    )

  self
)