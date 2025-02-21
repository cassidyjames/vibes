project(
  'com.cassidyjames.vibes',
  'vala', 'c',
  version: '0.0.0',
  meson_version: '>=1.3.2',
)

gnome = import('gnome')

application_id = 'com.cassidyjames.vibes'
project_name = meson.project_name()
prefix = get_option ('prefix')
data_dir = join_paths (prefix, get_option ('datadir'))
wallpapers_dir = join_paths (data_dir, project_name, 'wallpapers')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(application_id), language: 'c')
add_global_arguments('-DG_LOG_DOMAIN="@0@"'.format(application_id), language: 'c')

subdir('data')
subdir('src')