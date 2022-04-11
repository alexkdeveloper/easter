easter_sources = [
  'main.vala',
  'window.vala',
]

easter_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
]

gnome = import('gnome')

easter_sources += gnome.compile_resources('easter-resources',
  'easter.gresource.xml',
  c_name: 'easter'
)

executable('com.github.alexkdeveloper.easter', easter_sources,
  vala_args: '--target-glib=2.50',  dependencies: easter_deps,
  install: true,
)
