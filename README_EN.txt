* README_EN.txt
* 2020.04.06
* tacklelib--3dparty

1. DESCRIPTION
2. LICENSE
3. REPOSITORIES
4. PREREQUISITES
5. DEPENDENCIES
6. CATALOG CONTENT DESCRIPTION
7. PROJECT CONFIGURATION VARIABLES
8. PRECONFIGURE
9. CONFIGURE
10. USAGE
11. SSH+SVN/PLINK SETUP
12. KNOWN ISSUES
12.1. svn+ssh issues
12.1.1. Message `svn: E170013: Unable to connect to a repository at URL 'svn+ssh://...'`
        `svn: E170012: Can't create tunnel`
12.1.2. Message `Can't create session: Unable to connect to a repository at URL 'svn+ssh://...': `
        `To better debug SSH connection problems, remove the -q option from ssh' in the [tunnels] section of your Subversion configuration file. `
        `at .../Git/mingw64/share/perl5/Git/SVN.pm line 310.'`
12.1.3. Message `Keyboard-interactive authentication prompts from server:`
        `svn: E170013: Unable to connect to a repository at URL 'svn+ssh://...'`
        `svn: E210002: To better debug SSH connection problems, remove the -q option from 'ssh' in the [tunnels] section of your Subversion configuration file.`
        `svn: E210002: Network connection closed unexpectedly`
12.2. Python execution issues
12.2.1. `OSError: [WinError 6] The handle is invalid`
12.2.2. `ValueError: 'cwd' in __slots__ conflicts with class variable`
12.2.3. `TypeError: descriptor 'combine' for type 'datetime.datetime' doesn't apply to type 'datetime'`
12.3. pytest execution issues
12.4. fcache execution issues
13. AUTHOR

-------------------------------------------------------------------------------
1. DESCRIPTION
-------------------------------------------------------------------------------
Tacklelib 3dparty (tacklelib--3dparty) project, initial steps for both
the Windows and the Linux like targets and related build issues.

-------------------------------------------------------------------------------
2. LICENSE
-------------------------------------------------------------------------------
The MIT license (see included text file "license.txt" or
https://en.wikipedia.org/wiki/MIT_License)

-------------------------------------------------------------------------------
3. REPOSITORIES
-------------------------------------------------------------------------------
Primary:
  * https://sf.net/p/tacklelib/tacklelib--3dparty/HEAD/tree/trunk
  * https://svn.code.sf.net/p/tacklelib/tacklelib--3dparty/trunk
First mirror:
  * https://github.com/andry81/tacklelib--3dparty/tree/trunk
  * https://github.com/andry81/tacklelib--3dparty.git
Second mirror:
  * https://bitbucket.org/andry81/tacklelib-3dparty/src/trunk
  * https://bitbucket.org/andry81/tacklelib-3dparty.git

The `tacklelib` library repositories:

Primary:
  * https://sf.net/p/tacklelib/tacklelib/HEAD/tree/trunk
  * https://svn.code.sf.net/p/tacklelib/tacklelib/trunk
First mirror:
  * https://github.com/andry81/tacklelib/tree/trunk
  * https://github.com/andry81/tacklelib.git
Second mirror:
  * https://bitbucket.org/andry81/tacklelib/src/trunk
  * https://bitbucket.org/andry81/tacklelib.git

-------------------------------------------------------------------------------
4. PREREQUISITES
-------------------------------------------------------------------------------

Currently used these set of OS platforms, compilers, interpreters, modules,
IDE's, applications and patches to run with or from:

1. OS platforms:

* Windows 7 (`.bat` only, minimal version for the cmake 3.14)
* Cygwin 1.5+ or 3.0+ (`.sh` only):
  https://cygwin.com
  - to run scripts under cygwin
* Msys2 20190524+ (`.sh` only):
  https://www.msys2.org
  - to run scripts under msys2
* Linux Mint 18.3 x64 (`.sh` only)

2. C++11 compilers:

* (primary) Microsoft Visual C++ 2015 Update 3 or Microsoft Visual C++ 2017
* (secondary) GCC 5.4+
* (experimental) Clang 3.8+

3. Interpreters:

* bash shell 3.2.48+
  - to run unix shell scripts
* perl 5.10+
  - to run specific bash script functions with `perl` calls
* python 3.7.3 or 3.7.5 (3.6.2+)
  https://python.org
  - standard implementation to run python scripts
  - 3.7.4 has a bug in the `pytest` module execution (see `KNOWN ISSUES`
    section).
  - 3.6.2+ is required due to multiple bugs in the python implementation prior
    this version (see `KNOWN ISSUES` section).
  - 3.5+ is required for the direct import by a file path (with any extension)
    as noted in the documentation:
    https://docs.python.org/3/library/importlib.html#importing-a-source-file-directly

4. Modules:

* Python site modules:

**  xonsh/0.9.12
    https://github.com/xonsh/xonsh
    - to run python scripts and import python modules with `.xsh` file
      extension
**  plumbum 1.6.7
    https://plumbum.readthedocs.io/en/latest/
    - to run python scripts in a shell like environment
**  win_unicode_console
    - to enable unicode symbols support in the Windows console
**  pyyaml 5.1.1
    - to read yaml format files (.yaml, .yml)
**  conditional 1.3
    - to support conditional `with` statements
**  fcache 0.4.7
    - for local cache storage for python scripts
**  psutil 5.6.7
    - for processes list request
**  tzlocal 2.0.0
    - for local timezone request

Temporary dropped usage:

**  prompt-toolkit 2.0.9
    - optional dependency to the Xonsh on the Windows
**  cmdix 0.2.0
    https://github.com/jaraco/cmdix
    - extension to use Unix core utils within Python environment as plain
      executable or python function

5. IDE's:

Not required.

6. Applications:

* subversion 1.8+
  https://tortoisesvn.net
  - to run svn client
* git 2.24+
  https://git-scm.com
  - to run git client
* cygwin cygpath 1.42+
  - to run `bash_entry` script under cygwin
* msys cygpath 3.0+
  - to run `bash_entry` script under msys2
* cygwin readlink 6.10+
  - to run specific bash script functions with `readlink` calls

7. Patches:

* Python site modules contains patches in the `_pyxvcs/python_patches`
  subdirectory:

** fcache
   - to fix issues from the `fcache execution issues` section.

-------------------------------------------------------------------------------
5. DEPENDENCIES
-------------------------------------------------------------------------------
Any project which is dependent on this project have has to contain the
`README_EN.deps.txt` description file for the common dependencies in the
Windows and in the Linux like platforms.

NOTE:
  To run bash shell scripts (`.sh` file extension) you should copy from the
  `tacklelib` library the `/bash/tacklelib/bash_entry` module into the `/bin`
  directory of your platform.

NOTE:
  To install python all required modules at once you can use
  `install_python_modules.*` script as:
  `install_python_modules.* <path-to-pathon-executable>`

The project contains dependencies which must be taken and stored manually into
`_src` directory, these are:

* `boost` -> `_src/utility/boost/boost_1_72_0`:
  https://boost.org

-------------------------------------------------------------------------------
6. CATALOG CONTENT DESCRIPTION
-------------------------------------------------------------------------------

The example directory structure is this:

/<root>
  |
  +-/_scripts/01_checkout
  |        - The root checkout scripts directory, represents context for all
  |          projects together. Any script execution in that directory has to
  |          be applied for all projects represented in subdirectories
  |          respectively.
  |
  +-/_scripts/02_build
  |        - The root build scripts directory.
  |
  +-/_src
           - The working copy root directory for a particular project group.
             Stores sources in a subdirectory as a vcs working copy or as a
             local source files.

The `01_checkout` directory contains configuration files with various
parameters along with parameters which can be passed to command scripts in
these directories.

The system loads configuration files in directories from the root to the most
nested directory.

If a variable in a configuration file from nested directory is intersected with
the same variable in the parent directory, then the value from the nested one
is used instead (variable specialization).

-------------------------------------------------------------------------------
7. PROJECT CONFIGURATION VARIABLES
-------------------------------------------------------------------------------

1. `_config/config.vars`

Basic shell variables file designed to be used at a shell script level.

Stores these set of variables:

* PYTHON_EXE_PATH

Path to the python executable has used to run checkout scripts to checkout a
third party sources.

* PYTHONDONTWRITEBYTECODE

Python variable to suppress the generation of the byte code directory.

* CHCP

Code page locale variable to make readable all output from the Windows batch
scripts.

2. `_config/config.private.yaml`

Python script private variables file designed to declare user name, user email,
source code hub per a version control system and declare basic project paths
structure for a source code checkout. Can declare paths to checkout from public
or private repositories.

Stores these set of variables:

* `SVN_SF.HUB_ROOT`

Particulary for the Sourceforge the hub root path.

* `SVN_SF.HUB_ABBR`

Particularly for the Sourceforge the hub abbreviated name used to generate and
use the source code scripts to checkout or pull.

* `SVN_SF.USER`

Particularly for the Sourceforge the user name used to checkout the source code
from respective repository.

* `SVN_SF.PROJECT_PATH_LIST`

Particularly for the Sourceforge the project paths list there to generate
configuration files and checkout scripts.

3. `_config/config.yaml`

Python script root variables file designed to declare particular variables
related to a context like ssh protocol, local cache, git-svn conversion and
etc. Generates together with the same files addressed by the project paths
from all `*.PROJECT_PATH_LIST` variables.

Stores these set of variables:

* `SVN_SSH_ENABLED` or `GIT_SSH_ENABLED`

Enables SSH key usage for a particular version control system.
An appropriate protocol utilizes the ssh key must be already applied to all
related urls begins, for example, by `svn+ssh://` or `git+ssh://`.
It you don't not use respective ssh protocols, they you not need these
variables.

* `SVN_SSH_AGENT` or `GIT_SSH_AGENT` or `GIT_SVN_SSH_AGENT`

Different SSH agent applications uses the SSH key with a particular version
control system like SVN or GIT.
These variables basically stores paths which is addressed from `SVN_SSH` and
`GIT_SSH` environment variables together with the user name has used to
checkout the source code.
It you don't not use respective ssh protocols, they you not need these
variables.

* `LOCAL_CACHE_ROOT`

Local cache storage for respective python scripts.

3. `_config/config.env.yaml`

Python script environment variables file designed to declare environment
variables for particular or all external processes being called from python
scripts.

Each variable in this script has special format to declare conditional
environment variables.

Format 1:

<var>: "<string_value>"
<var>: '<string_value>'
<var>: [<command_line_list>]

Format 2:

<var>:
  apps: [<application_absolute_path_list_for_which_variable_is_declared>]
  value: <a_value>

Format 3:

<var>:
  if: '<python_condition>'
  apps: [<application_absolute_path_list_for_which_variable_is_declared>]
  values:
    - if: '<python_condition_1>'
      value: [<command_line_list_for_a_condition_1>]
    :
    - if: '<python_condition_N>'
      value: [<command_line_list_for_a_condition_N>]

Stores these set of variables:

* `SVN_SSH` or `GIT_SSH`

Stores command lines for particular SSH agent.

-------------------------------------------------------------------------------
8. PRECONFIGURE
-------------------------------------------------------------------------------
N/A

-------------------------------------------------------------------------------
9. CONFIGURE
-------------------------------------------------------------------------------

From the root directory:

1. Run the `configure.*` script.

From the `01_checkout` subdirectory:

1. Run the `01_configure.vars.*` script.
   Edit `config.vars` variables for correct values.
2. Run the `02_configure.private.*` script.
   Edit `*.HUB_ABBR` and `*.PROJECT_PATH_LIST` variables to define how and
   where to generate respective command scripts.
   Edit all other variables from the `config.private.yaml` file.
3. Run the `03_configure.root_yaml.*` script.
   Edit `SVN_SSH_ENABLED` and `GIT_SSH_ENABLED` variables to properly
   enable/disable ssh protocol usage from the svn/git utilities.
   Edit `SVN_SSH_AGENT`, `GIT_SSH_AGENT`, `GIT_SVN_SSH_AGENT` variables related
   to the ssh protocol.
4. Run the `04_configure.project_yaml.*` script.
   Edit the `WCROOT_OFFSET` variable in the respective `config.yaml` file
   and change the default working copies directory structure if is required to.
   Edit all other variables in `config.yaml` and `config.env.yaml` files.
5. Run the `05_configure.*` script.
6. (Only in case of usage the Linux like environment)
   Run the `06_configure.chmod.*` script.

Note:
  Step 6 must be issued in the terminal with appropriate permissions.

-------------------------------------------------------------------------------
10. USAGE
-------------------------------------------------------------------------------

Any deploy script format:
  `<HubAbbrivatedName>~<ScmName>~<CommandOperation>.*`, where:

  `HubAbbrivatedName` - Hub abbrivated name to run a command for.
  `ScmName`           - Version Source Control service name in a hub.
  `CommandOperation`  - Command operation name to request.

  `HubAbbrivatedName` can be:
    `sf` - SourceForge
    `gl` - GitLab
    `gh` - GitHub
    `bb` - BitBucket

  `ScmName` can be:
    `git` - git source control
    `svn` - svn source control

  `CommandOperation` can be:

  [ScmName=git]
    `init`      - create and initialize local git working copy directory.
    `fetch`     - fetch remote git repositories and optionally does
                  (by default is) the fetch of all subtrees.
    `pull`      - pull remote git repositories and optionally does
                  (by default is) the pull of all subtrees.
    `reset`     - reset local working copy and optionally does
                  (by default is) the reset of all subtree working copies.
  [ScmName=svn]
    `checkout`  - checks out an svn repository into new svn working copy
                  directory.
    `update`    - updates svn working copy directory from a remote svn
                  repository.
    `relocate`  - changes in the local working copy the url onto different
                  remote svn repository (for example, to change the url
                  scheme use these parameters: `https://` `svn+ssh://`).

-------------------------------------------------------------------------------
11. SSH+SVN/PLINK SETUP
-------------------------------------------------------------------------------
Based on: https://stackoverflow.com/questions/11345868/how-to-use-git-svn-with-svnssh-url/58641860#58641860

The svn+ssh protocol must be setuped using both the private and the public ssh
key.

In case of in the Windows usage you have to setup the ssh key before run the
svn client using these general steps related to the native Windows `svn.exe`
(should not be a ported one, for example, like the `msys` or `cygwin` tools
which is not fully native):

1. Install the `putty` client.
2. Generate the key using the `puttygen.exe` utility and the correct type of
   the key dependent on the svn hub server (Ed25519, RSA, DSA, etc).
3. Install the been generated public variant of the key into the svn hub server
   by reading the steps from the docs to the server.
4. Ensure that the `SVN_SSH` environment variable in the generated
   `config.env.yaml` file is pointing a correct path to the `plink.exe` and
   uses valid arguments. This would avoid hangs in scripts because of
   interactive login/password request and would avoid usage svn repository
   urls with the user name inside.
5. Ensure that all svn working copies and the `externals` properties in them
   contains valid svn repository urls with the `svn+ssh://` prefix. If not then
   use the `*~svn~relocate.*` scrtip(s) to switch onto it. Then fix all the
   rest urls in the `externals` properties, for example, just by remove the url
   scheme prefix and leave the `//` prefix instead.
6. Run the `pageant.exe` in the background with the previously generated
   private key (add it).
7. Test the connection to the svn hub server through the `putty.exe` client.
   The client should not ask for the password if the `pageant.exe` is up and
   running with has been correctly setuped private key. The client should not
   ask for the user name either if the `SVN_SSH` environment variable is
   declared with the user name.

The `git` client basically is a part of ported `msys` or `cygwin` tools, which
means they behaves a kind of differently.

The one of the issues with the message `Can't create session: Unable to connect
to a repository at URL 'svn+ssh://...': Error in child process: exec of ''
failed: No such file or directory at .../Git/mingw64/share/perl5/Git/SVN.pm
line 310.` is the issue with the `SVN_SSH` environment variable. The variable
should be defined with an utility from the same tools just like the `git`
itself. The attempt to use it with the standalone `plink.exe` from the `putty`
application would end with that message.

So, additionally to the steps for the `svn.exe` application you should apply,
for example, these steps:

1. Drop the usage of the `SVN_SSH` environment variable and remove it.
2. Run the `ssh-pageant` from the `msys` or `cygwin` tools (the `putty`'s
   `pageant` must be already run with the valid private key). You can read
   about it, for example, from here: https://github.com/cuviper/ssh-pageant
   ("ssh-pageant is a tiny tool for Windows that allows you to use SSH keys
   from PuTTY's Pageant in Cygwin and MSYS shell environments.")
3. Create the environment variable returned by the `ssh-pageant` from the
   stdout, for example: `SSH_AUTH_SOCK=/tmp/ssh-hNnaPz/agent.2024`.
4. Use urls in the `git svn ...` commands together with the user name as stated
   in the documentation
   (https://git-scm.com/docs/git-svn#Documentation/git-svn.txt---usernameltusergt ):
   `svn+ssh://<USERNAME>@svn.<url>.com/repo`
   ("For transports that SVN handles authentication for (http, https, and plain
   svn), specify the username. For other transports (e.g. svn+ssh://), you
   **must include the username in the URL**,
   e.g. svn+ssh://foo@svn.bar.com/project")

These instructions should help to use `git svn` commands together with the
`svn` commands.

NOTE:
  The scripts does all above automatically. All you have to do is to ensure
  that you are using valid paths and keys in the respective configuration
  files.

-------------------------------------------------------------------------------
12. KNOWN ISSUES
-------------------------------------------------------------------------------
For the issues around python xonsh module see details in the
`README_EN.python_xonsh.known_issues.txt` file.

-------------------------------------------------------------------------------
12.1. svn+ssh issues
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
12.1.1. Message `svn: E170013: Unable to connect to a repository at URL 'svn+ssh://...'`
        `svn: E170012: Can't create tunnel`
-------------------------------------------------------------------------------

Issue #1:

  The `svn ...` command was run w/o properly configured putty plink utility or
  w/o the `SVN_SSH` environment variable with the user name parameter.

Solution:

  Carefully read the `SSH+SVN/PLINK SETUP` section to fix most of the cases.

Issue #2

  The `SVN_SSH` environment variable have has the backslash characters - `\`.

Solution:

  Replace all the backslash characters by forward slash character - `/` or by
  double baskslash character - `\\`.

Issue #3

  The `config.private.yaml` contains invalid values or was regenerated to
  default values.

Solution:

  Manually edit variables in the file for correct values.

-------------------------------------------------------------------------------
12.1.2. Message `Can't create session: Unable to connect to a repository at URL 'svn+ssh://...': `
        `To better debug SSH connection problems, remove the -q option from ssh' in the [tunnels] section of your Subversion configuration file. `
        `at .../Git/mingw64/share/perl5/Git/SVN.pm line 310.'`
-------------------------------------------------------------------------------

Issue:

  The `git svn ...` command should not be called with the `SVN_SSH` variable
  declared for the `svn ...` command.

Solution:

  Read docs about the `ssh-pageant` usage from the msys tools to fix that.

  See details: https://stackoverflow.com/questions/31443842/svn-hangs-on-checkout-in-windows/58613014#58613014

NOTE:
  The scripts does automatic maintain of the `ssh-pageant` utility startup.
  All you have to do is to ensure that you are using valid paths and keys in
  the respective configuration files.

-------------------------------------------------------------------------------
12.1.3. Message `Keyboard-interactive authentication prompts from server:`
        `svn: E170013: Unable to connect to a repository at URL 'svn+ssh://...'`
        `svn: E210002: To better debug SSH connection problems, remove the -q option from 'ssh' in the [tunnels] section of your Subversion configuration file.`
        `svn: E210002: Network connection closed unexpectedly`
-------------------------------------------------------------------------------

Related command: `git svn ...`

Issue #1:

  Network is disabled:

Issue #2:

  The `pageant` application is not running or the provate SSH key is not added.

Issue #3:

  The `ssh-pageant` utility is not running or the `git svn ...` command does
  run without the `SSH_AUTH_SOCK` environment variable properly registered.

Solution:

  Read the deatils in the `SSH+SVN/PLINK SETUP` section.

-------------------------------------------------------------------------------
12.2. Python execution issues
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
12.2.1. `OSError: [WinError 6] The handle is invalid`
-------------------------------------------------------------------------------

Issue:

  The python interpreter (3.7, 3.8, 3.9) sometimes throws this message at exit,
  see details here:

  `subprocess.Popen._cleanup() "The handle is invalid" error when some old process is gone` :
  https://bugs.python.org/issue37380

Solution:

  Reinstall a different python version.

-------------------------------------------------------------------------------
12.2.2. `ValueError: 'cwd' in __slots__ conflicts with class variable`
-------------------------------------------------------------------------------

Stack trace example:

  File ".../python/tacklelib/tacklelib.py", line 265, in tkl_classcopy
    cls_copy = type(x.__name__, x.__bases__, dict(x.__dict__))

Issue:

  Bug in the python implementation prior version 3.5.4 or 3.6.2:

  https://stackoverflow.com/questions/45864273/slots-conflicts-with-a-class-variable-in-a-generic-class/45868049#45868049
  `typing module conflicts with __slots__-classes` :
  https://bugs.python.org/issue31272

Solution:

  Upgrade python version at least up to 3.5.4 or 3.6.2.

-------------------------------------------------------------------------------
12.2.3. `TypeError: descriptor 'combine' for type 'datetime.datetime' doesn't apply to type 'datetime'`
-------------------------------------------------------------------------------

Stack trace example:

  File ".../python/tacklelib/tacklelib.py", line 278, in tkl_classcopy
    for key, value in dict(inspect.getmembers(x)).items():
  File ".../python/x86/35/lib/python3.5/inspect.py", line 309, in getmembers
    value = getattr(object, key)

Issue:

  Bug in the python implementation prior version 3.6.2:

Solution:

  Upgrade python version at least up to 3.6.2.

-------------------------------------------------------------------------------
12.3. pytest execution issues
-------------------------------------------------------------------------------
* `xonsh incorrectly reorders the test for the pytest` :
  https://github.com/xonsh/xonsh/issues/3380
* `a test silent ignore` :
  https://github.com/pytest-dev/pytest/issues/6113
* `can not order tests by a test directory path` :
  https://github.com/pytest-dev/pytest/issues/6114

-------------------------------------------------------------------------------
12.4. fcache execution issues
-------------------------------------------------------------------------------
* `fcache is not multiprocess aware on Windows` :
  https://github.com/tsroten/fcache/issues/26
* ``_read_from_file` returns `None` instead of (re)raise an exception` :
  https://github.com/tsroten/fcache/issues/27
* `OSError: [WinError 17] The system cannot move the file to a different disk drive.` :
  https://github.com/tsroten/fcache/issues/28

-------------------------------------------------------------------------------
13. AUTHOR
-------------------------------------------------------------------------------
Andrey Dibrov (andry at inbox dot ru)
