import os

# auto export these globals to all child modules
tkl_declare_global('CONFIGURE_ROOT', SOURCE_DIR)
tkl_declare_global('PYXVCS_SCRIPTS_ROOT', os.environ['PYXVCS_SCRIPTS_ROOT'])

tkl_declare_global('LOCAL_CONFIG_DIR_NAME', os.environ['LOCAL_CONFIG_DIR_NAME'])
tkl_declare_global('TMPL_CMDOP_FILES_DIR', os.environ['TMPL_CMDOP_FILES_DIR'])

tkl_declare_global('CONTOOLS_ROOT', os.environ['CONTOOLS_ROOT'])
tkl_declare_global('TACKLELIB_ROOT', os.environ['TACKLELIB_ROOT'])
tkl_declare_global('CMDOPLIB_ROOT', os.environ['CMDOPLIB_ROOT'])

tkl_declare_global('LOCAL_CACHE_ROOT', CONFIGURE_ROOT + '/_cache')

tkl_declare_global('PYTHON_EXE_PATH', os.environ['PYTHON_EXE_PATH'])
tkl_declare_global('PYTHON_EXE_FILE_NAME', os.path.basename(PYTHON_EXE_PATH))

tkl_source_module(CMDOPLIB_ROOT, 'cmdoplib.xsh')

is_config_private_loaded = False
for config_dir in [CONFIGURE_ROOT + '/' + LOCAL_CONFIG_DIR_NAME, CONFIGURE_ROOT]:
  if not os.path.exists(config_dir):
    continue

  if os.path.isfile(os.path.join(config_dir, 'config.private.yaml.in')) and os.path.isfile(os.path.join(config_dir, 'config.private.yaml')):
    yaml_load_config(config_dir, 'config.private.yaml')
    is_config_private_loaded = True
    break # break on success

if not is_config_private_loaded:
  raise Exception(
    'The `config.private.yaml` is not generated, call to `configure.private.*` script, edit `*.HUB_ABBR` variable values and '
    'call to `configure.*` to generate the rest of configuration files and affected by the `*.HUB_ABBR` variable scripts. '
    'The `*.HUB_ABBR` must begins by one of these values: [SVN, GIT].'
  )

for config_dir in [CONFIGURE_ROOT + '/' + LOCAL_CONFIG_DIR_NAME, CONFIGURE_ROOT]:
  if not os.path.exists(config_dir):
    continue

  if os.path.isfile(os.path.join(config_dir, 'config.yaml.in')) and os.path.isfile(os.path.join(config_dir, 'config.yaml')):
    yaml_load_config(config_dir, 'config.yaml', to_globals = True, to_environ = False,
      search_by_global_pred_at_third = lambda var_name: getglobalvar(var_name))
    break # break on success

for config_dir in [CONFIGURE_ROOT + '/' + LOCAL_CONFIG_DIR_NAME, CONFIGURE_ROOT]:
  if not os.path.exists(config_dir):
    continue

  if os.path.isfile(os.path.join(config_dir, 'config.env.yaml.in')) and os.path.isfile(os.path.join(config_dir, 'config.env.yaml')):
    yaml_load_config(config_dir, 'config.env.yaml', to_globals = False, to_environ = True,
      search_by_environ_pred_at_third = lambda var_name: getglobalvar(var_name))
    break # break on success
