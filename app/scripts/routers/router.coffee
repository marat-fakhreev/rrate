class Router extends Marionette.AppRouter
  appRoutes:
    '': 'index'
    'api': 'stub'
    'bus': 'stub'
    'def': 'stub'
    'questions': 'questions'
    # temporary cludge with ".html" paths
    'api.html': 'stub'
    'bus.html': 'stub'
    'def.html': 'stub'
    'questions.html': 'questions'

module.exports = Router
