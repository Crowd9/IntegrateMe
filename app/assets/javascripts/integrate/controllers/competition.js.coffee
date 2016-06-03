angular.module('integrate').controller('CompetitionController', ($scope, $http) ->
  self = @

  @init = (data) ->
    self.competition = data.competition
    self.unsynced_entries = data.competition.unsynced_entries

  @resync_entry = (entry_id) ->
    $http.post("/api/entries/#{entry_id}/resync").
      success((data, status, headers, config) ->
        self.unsynced_entries = self.unsynced_entries.filter((entry) -> entry.id != entry_id)
      ).
      error((data, status, headers, config) ->
        if data.error_message
          alert("SYNC ERROR: #{data.error_message}")
        else
          alert("SERVER ERROR: #{status}")
      )

  self
)
