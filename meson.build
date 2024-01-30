project('main', 'c', 'vala')

sources = [
    'main.vala',
]

vapi_dir = meson.current_source_dir() / 'vapi'

add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

deps = [ 
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gee-0.8'),
    dependency('gio-2.0'),
    dependency('glfw3'),
    dependency('gl'),

]


executable('main', sources, dependencies: deps)