config_data = configuration_data()

config_data.set_quoted('APP_ID', meson.project_name())
config_data.set_quoted('VERSION', meson.project_version())
config_data.set_quoted('WALLPAPERS_DIR', wallpapers_dir)

config_file = configure_file(
  input: 'Config.vala.in',
  output: '@BASENAME@',
  configuration: config_data
)

executable(
  meson.project_name(),
  'App.vala',
  'MainWindow.vala',
  asresources,
  config_file,
  vala_args: [ '--gresourcesdir=data/' ],
  dependencies: [
    dependency('gtk4', version: '>=4.14.4'),
    dependency('libadwaita-1', version: '>=1.5.2'),
    dependency('libportal', version: '>=0.8.1'),
    dependency('libportal-gtk4', version: '>=0.8.1')
  ],
  install: true
)