project('main', 'c', 'vala')

sources = [
    'main.vala',
]

vapi_dir = meson.current_source_dir() / 'vapi'

add_project_arguments(['--vapidir', vapi_dir], language: 'vala')
# add_project_arguments(['-framework OpenGL'], language: 'vala')

deps = [ 
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gee-0.8'),
    dependency('gio-2.0'),
    dependency('sdl2'),
    dependency('gl'),
    dependency('glfw3'),

    dependency('SDL2_gfx'),
    dependency('SDL2_image'),
]


executable('main', sources, dependencies: deps, vala_args: ['--pkg', 'gl'], )