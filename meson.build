project('easter', ['c', 'vala'],
          version: '0.1.0',
    meson_version: '>= 0.53.2',
  default_options: [ 'warning_level=2',
                   ],
)

i18n = import('i18n')

subdir('data')
subdir('src')
subdir('po')

meson.add_install_script('meson/postinstall.py')
