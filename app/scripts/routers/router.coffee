class Router extends Marionette.AppRouter
  appRoutes:
    '': 'index'
    'api': 'stub'
    'bus': 'stub'
    'def': 'stub'
    # temporary cludge with .html
    'api.html': 'stub'
    'bus.html': 'stub'
    'def.html': 'stub'

module.exports = Router
