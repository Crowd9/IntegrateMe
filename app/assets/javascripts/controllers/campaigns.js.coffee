angular.module('integrate').controller('CampaignsController', ($scope, $http) ->
  self = @

  @init = (data) ->
    self.campaign = data.campaign

  @submit = ->
    $http.post("/campaigns", self.campaign).
    success((data, status, headers, config) ->
      console.log(self.campaign, data)
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