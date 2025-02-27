install_data(
  'icons' / project_name + '.svg',
  install_dir: get_option('datadir') / 'icons' / 'hicolor' / 'scalable' / 'apps',
)

install_data(
  'icons' / project_name + '-symbolic.svg',
  install_dir: get_option('datadir') / 'icons' / 'hicolor' / 'symbolic' / 'apps',
)

install_data(
  'icons' / project_name + '.svg',
  install_dir: get_option('datadir') / 'icons' / 'hicolor' / 'scalable' / 'apps',
)

blueprint_compiler = find_program('blueprint-compiler', required: true)
blueprints = custom_target('blueprints',
  input: files(
    'ui' / 'main.blp',
  ),
  output: '.',
  command: [ blueprint_compiler, 'batch-compile', '@OUTPUT@', '@CURRENT_SOURCE_DIR@', '@INPUT@' ],
)

asresources = gnome.compile_resources(
  'as-resources', 'gresource.xml',
  source_dir: 'data',
  c_name: 'as',
  dependencies: blueprints,
)

install_data(
  'launcher.desktop',
  install_dir: get_option('datadir') / 'applications',
  rename: project_name + '.desktop'
)

install_data(
  'metainfo.xml',
  install_dir: get_option('datadir') / 'metainfo',
  rename: project_name + '.metainfo.xml'
)

desktop_file_validate = find_program('desktop-file-validate', required:false)
if desktop_file_validate.found()
  test (
    'Validate desktop file',
    desktop_file_validate,
    args: meson.current_build_dir () / project_name + '.desktop'
  )
endif

install_subdir(
  'wallpapers',
  install_dir: wallpapers_dir,
  strip_directory: true
)