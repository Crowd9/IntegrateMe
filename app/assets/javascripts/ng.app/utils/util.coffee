angular.module('demo.utils').factory 'Util', ["$q", "$http", "$routeParams",
  ($q, $http, $routeParams)->
    service = {}
    service.submitRequest = (url, method, config, successCallback, errorCallback)->
      ret = $q.defer();
      config = config || {}
      config.url = url
      config.method = method
      config.timeout = ret

      $http config
      .success (respondData)->
        ret.resolve(respondData)
        successCallback(respondData) if successCallback
      .error (error, status, headers, config)->
        if status == 401 && window.location.href.indexOf(Routes.new_user_session_path()) == -1 || status == 422 && error.message && error.message.indexOf("ActionController::InvalidAuthenticityToken") >= 0
          window.location.href = "/" + $routeParams.locale + Routes.destroy_user_session_path()
        else
          errorCallback(error, status, headers, config) if errorCallback
        ret.reject(undefined)

      ret

    service
]
