class Router extends Marionette.AppRouter
  appRoutes:
    '': 'index'
    'api': 'stub'
    'bus': 'stub'
    'def': 'stub'
    'anketirovanie': 'anketirovanie'
    # temporary cludge with ".html" paths
    'api.html': 'stub'
    'bus.html': 'stub'
    'def.html': 'stub'
    'anketirovanie.html': 'anketirovanie'

module.exports = Router
